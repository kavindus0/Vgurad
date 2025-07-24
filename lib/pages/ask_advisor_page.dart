import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:vguard/core/app_constants.dart';

final apiKey = dotenv.env['_geminiApiKey'];

class Message {
  final String text;
  final bool isUser; // true for user, false for advisor
  final bool isLoading; // true if awaiting response

  Message(this.text, {required this.isUser, this.isLoading = false});
}

class AskAdvisorPage extends StatefulWidget {
  const AskAdvisorPage({super.key});

  @override
  State<AskAdvisorPage> createState() => _AskAdvisorPageState();
}

class _AskAdvisorPageState extends State<AskAdvisorPage> {
  final TextEditingController _questionController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final List<Message> _messages = [];
  late final GenerativeModel _model;
  bool _isSending = false;

  @override
  void initState() {
    super.initState();
    _model = GenerativeModel(
      model: 'gemini-1.5-flash',
      apiKey: apiKey ?? '',
      safetySettings: [
        SafetySetting(HarmCategory.harassment, HarmBlockThreshold.none),
        SafetySetting(HarmCategory.hateSpeech, HarmBlockThreshold.none),
        SafetySetting(HarmCategory.sexuallyExplicit, HarmBlockThreshold.none),
        SafetySetting(HarmCategory.dangerousContent, HarmBlockThreshold.none),
      ],
    );

    _messages.add(
      Message(
        "Hello! I am your AI Agricultural Advisor. How can I assist you with your farming queries today?",
        isUser: false,
      ),
    );
  }

  @override
  void dispose() {
    _questionController.dispose();
    super.dispose();
  }

  Future<void> _sendMessage() async {
    if (!_formKey.currentState!.validate()) {
      return; // Stop if validation fails
    }

    final String userQuestion = _questionController.text.trim();
    if (userQuestion.isEmpty) {
      return;
    }

    setState(() {
      _messages.add(Message(userQuestion, isUser: true));
      _messages.add(
        Message('', isUser: false, isLoading: true),
      ); // Add a loading indicator message
      _isSending = true; // Disable input
    });

    _questionController.clear(); // Clear the input field

    try {
      final content = [
        Content.text(
          "You are a professional and helpful agricultural advisor. Provide concise, accurate, and practical advice related to farming, crops, diseases, pests, and general agricultural practices. If you cannot answer a question, state that politely. Be encouraging and supportive.",
        ),
        Content.text(userQuestion),
      ];

      final response = await _model.generateContent(content);

      setState(() {
        _messages.removeLast(); // Remove the loading indicator
        _messages.add(
          Message(
            response.text ??
                "Sorry, I couldn't get a response. Please try again.",
            isUser: false,
          ),
        );
        _isSending = false; // Re-enable input
      });

      _showThankYouSnackBar();
    } catch (e) {
      setState(() {
        _messages.removeLast(); // Remove loading indicator even on error
        _messages.add(
          Message(
            "Error: Could not get a response. Please check your internet connection or API key.",
            isUser: false,
          ),
        );
        _isSending = false; // Re-enable input
      });
      print('Error sending message to Gemini: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to get advisor response: $e'),
          backgroundColor: AppColors.red,
        ),
      );
    }
  }

  void _showThankYouSnackBar() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.check_circle_outline, color: AppColors.white),
            const SizedBox(width: AppSizes.paddingSmall),
            Text(
              'Thank you for your question!',
              style: TextStyle(color: AppColors.white),
            ),
          ],
        ),
        backgroundColor: AppColors.primaryGreen,
        duration: const Duration(seconds: 3),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSizes.borderRadiusMedium),
        ),
        margin: const EdgeInsets.all(AppSizes.paddingLarge),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.darkGreen,
        elevation: AppSizes.cardElevation,
        automaticallyImplyLeading: false,
        title: Image.asset(
          'assets/images/logo.png',
          height: 150,
          width: 150,
          fit: BoxFit.contain,
        ),
      ),
      body: Column(
        children: [
          Container(
            color: AppColors.lightGreenBackground,
            padding: const EdgeInsets.symmetric(
              horizontal: AppSizes.paddingLarge,
              vertical: AppSizes.paddingMedium,
            ),
            alignment: Alignment.centerLeft,
            child: Row(
              children: [
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.arrow_back),
                  label: const Text('Back'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.white,
                    foregroundColor: AppColors.black87,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        AppSizes.borderRadiusMedium,
                      ),
                      side: BorderSide(color: AppColors.grey300),
                    ),
                    elevation: AppSizes.cardElevation,
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSizes.paddingMedium,
                      vertical: AppSizes.paddingSmall + 4,
                    ),
                  ),
                ),
                const SizedBox(width: AppSizes.horizontalSpacing),
                const Text(
                  'AI Agricultural Advisor',
                  style: AppTextStyles.pageHeaderTitle,
                ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(100),
              child: ListView.builder(
                reverse: false,
                itemCount: _messages.length,
                itemBuilder: (context, index) {
                  final message = _messages[index];
                  return _buildMessageBubble(message);
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(AppSizes.paddingMedium),
            child: Form(
              key: _formKey,
              child: Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _questionController,
                      enabled: !_isSending, // Disable input while sending
                      decoration: InputDecoration(
                        hintText: 'Ask your question...',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(
                            AppSizes.borderRadiusLarge,
                          ),
                          borderSide: BorderSide(color: AppColors.grey300),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(
                            AppSizes.borderRadiusLarge,
                          ),
                          borderSide: BorderSide(color: AppColors.grey300),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(
                            AppSizes.borderRadiusLarge,
                          ),
                          borderSide: BorderSide(
                            color: AppColors.primaryGreen,
                            width: 2,
                          ),
                        ),
                        filled: true,
                        fillColor: AppColors.white,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: AppSizes.paddingLarge,
                          vertical: AppSizes.paddingMedium,
                        ),
                      ),
                      maxLines: null, // Allow multiple lines
                      keyboardType: TextInputType.multiline,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Question cannot be empty.';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(width: AppSizes.paddingSmall),
                  FloatingActionButton(
                    onPressed:
                        _isSending
                            ? null
                            : _sendMessage, // Disable button while sending
                    backgroundColor:
                        _isSending ? AppColors.grey400 : AppColors.primaryGreen,
                    child:
                        _isSending
                            ? const SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(
                                color: AppColors.white,
                                strokeWidth: 2,
                              ),
                            )
                            : const Icon(Icons.send, color: AppColors.white),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMessageBubble(Message message) {
    return Align(
      alignment: message.isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(
          vertical: AppSizes.paddingSmall / 2,
          horizontal: AppSizes.paddingSmall,
        ),
        padding: const EdgeInsets.all(AppSizes.paddingMedium),
        decoration: BoxDecoration(
          color:
              message.isUser
                  ? AppColors.primaryGreen
                  : AppColors.lightGreenBackground,
          borderRadius: BorderRadius.circular(
            AppSizes.borderRadiusMedium,
          ).copyWith(
            bottomLeft:
                message.isUser
                    ? const Radius.circular(AppSizes.borderRadiusSmall)
                    : const Radius.circular(AppSizes.borderRadiusMedium),
            bottomRight:
                message.isUser
                    ? const Radius.circular(AppSizes.borderRadiusMedium)
                    : const Radius.circular(AppSizes.borderRadiusSmall),
          ),
          border: message.isUser ? null : Border.all(color: AppColors.grey300),
        ),
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.75,
        ),
        child:
            message.isLoading
                ? const SizedBox(
                  width: 24,
                  height: 24,
                  child: CircularProgressIndicator(
                    color: AppColors.primaryGreen,
                    strokeWidth: 2,
                  ),
                )
                : Text(
                  message.text,
                  style: TextStyle(
                    color: message.isUser ? AppColors.white : AppColors.black87,
                  ),
                ),
      ),
    );
  }
}
