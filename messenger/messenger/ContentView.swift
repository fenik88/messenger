import SwiftUI

struct ContentView: View {
    @State private var messageText = "" // Text message
    @State private var messages: [(String, Bool)] = [] // Array of messages (text, sent/received)
    @State private var selectedChatIndex = 0 // Index of the selected chat
    
    // Example chats
    let chats = ["Chat 1", "Chat 2", "Chat 3"]
    
    var body: some View {
        HStack(spacing: 0) {
            // Left chat panel
            VStack {
                HStack {
                    Button(action: {}) {
                        Image(systemName: "square.and.pencil") // Button for new chat
                            .font(.title)
                            .foregroundColor(.blue)
                            .padding()
                    }
                    Spacer()
                }
                Text("Chats")
                    .font(.title2)
                    .bold()
                    .padding(.top)
                    .padding(.leading)
                
                List(chats, id: \.self, selection: $selectedChatIndex) { chat in
                    HStack {
                        Circle()
                            .frame(width: 50, height: 50)
                            .foregroundColor(.gray) // Round avatar
                        Text(chat)
                            .font(.body)
                            .padding(.leading)
                        Spacer()
                        Text("1 min ago")
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                    .padding(.vertical, 8)
                }
                .frame(width: 250)
                .background(Color.gray.opacity(0.1)) // Background color of chat panel
            }
            
            // Chat window
            VStack {
                // Chat header
                HStack {
                    Text(chats[selectedChatIndex])
                        .font(.title2)
                        .fontWeight(.bold)
                        .padding(.top)
                    Spacer()
                    Button(action: {}) {
                        Image(systemName: "info.circle")
                            .font(.title2)
                            .foregroundColor(.blue)
                            .padding(.top)
                    }
                }
                
                Spacer()
                
                // Message list
                ScrollView {
                    VStack(spacing: 15) {
                        ForEach(messages, id: \.0) { message, isSender in
                            HStack {
                                if isSender {
                                    Spacer()
                                }
                                Text(message)
                                    .padding()
                                    .background(isSender ? Color.blue : Color.gray.opacity(0.2))
                                    .foregroundColor(isSender ? .white : .black)
                                    .cornerRadius(15)
                                    .padding(.horizontal, 10)
                                if !isSender {
                                    Spacer()
                                }
                            }
                        }
                    }
                    .padding(.top)
                }
                
                // Message input field
                HStack {
                    TextField("Enter message...", text: $messageText)
                        .padding(10)
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(15)
                        .frame(height: 50)
                    
                    Button(action: sendMessage) {
                        Image(systemName: "paperplane.fill")
                            .font(.title)
                            .foregroundColor(.blue)
                            .padding(.leading, 8)
                    }
                    .padding(.trailing)
                }
                .padding()
            }
            .frame(maxWidth: .infinity)
            .background(Color.white)
        }
        .edgesIgnoringSafeArea(.all)
    }
    
    func sendMessage() {
        if !messageText.isEmpty {
            // Add the message to the array (first value is text, second is true for sent)
            messages.append((messageText, true))
            messageText = "" // Clear input field
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
