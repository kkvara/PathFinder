import SwiftUI
import Foundation

struct SingleNewsView: View {
    let news: News

    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                Image(news.imageName)
                    .resizable()
                    .scaledToFit()
                    .cornerRadius(15)
                    .padding()

                Text(news.title)
                    .font(.largeTitle)
                    .bold()
                    .foregroundColor(AppTheme.primaryColor)
                    .padding(.horizontal)

                Text(news.content)
                    .foregroundColor(AppTheme.primaryColor.opacity(0.85))
                    .font(.body)
                    .padding(.horizontal)

                Spacer()
            }
        }
        .background(AppTheme.backgroundGradient)
        .navigationTitle(news.title)
        .navigationBarTitleDisplayMode(.inline)
    }
}

