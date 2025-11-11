import SwiftUI

struct NewsView: View {
    let news: [News] = allNews

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 20) {
                    // Titolo "News" in bianco
                    Text("News")
                        .font(.largeTitle)
                        .bold()
                        .foregroundColor(.white)  // messaggio in bianco
                        .padding(.leading, 20)
                        .frame(maxWidth: .infinity, alignment: .leading)

                    // Lista verticale delle news
                    VStack(spacing: 15) {
                        ForEach(news) { item in
                            NavigationLink(destination: SingleNewsView(news: item)) {
                                NewsCardView(news: item)
                            }
                            .buttonStyle(PlainButtonStyle())
                        }
                    }
                    .padding(.horizontal, 20)
                }
                .padding(.vertical)
            }
            .background(AppTheme.backgroundGradient)
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

// Card per una singola news (resta uguale)
struct NewsCardView: View {
    let news: News

    var body: some View {
        HStack(spacing: 12) {
            Image(news.imageName)
                .resizable()
                .scaledToFill()
                .frame(width: 80, height: 80)
                .clipped()
                .cornerRadius(10)

            VStack(alignment: .leading, spacing: 4) {
                Text(news.title)
                    .font(.headline)
                    .foregroundColor(.white)
                    .lineLimit(1)
                Text(news.summary)
                    .font(.subheadline)
                    .foregroundColor(.white.opacity(0.8))
                    .lineLimit(2)
            }
            Spacer()
        }
        .padding()
        .background(Color.white.opacity(0.15))
        .cornerRadius(20)
        .shadow(radius: 6, x: 0, y: 2)
    }
}

#Preview {
    NewsView()
}
