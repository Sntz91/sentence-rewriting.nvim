import ollama
import sys

if len(sys.argv) <= 1:
    print("Need an input")
    sys.exit(1)

prompt = sys.argv[1]
# prompt = input("Input: ")
# Prompt Ollama with a question
response = ollama.chat(model='llama2', messages=[
    {'role': 'user', 'content': prompt}
])

# Print Ollama's response
print(response['message']['content'])
