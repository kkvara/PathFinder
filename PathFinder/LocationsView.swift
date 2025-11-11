import SwiftUI

@available(iOS 26.0, *)
struct LocationsView: View {
    let course: Course

    var body: some View {
        ZStack {
            AppTheme.backgroundGradient
                .ignoresSafeArea()

            VStack(spacing: 18) {
                VStack(spacing: 8) {
                    Image(systemName: "mappin.and.ellipse")
                        .font(.system(size: 36))
                        .foregroundColor(.white)
                    Text("LOCATIONS")
                        .font(.title2)
                        .bold()
                        .foregroundColor(.white)
                }

                ScrollView {
                    VStack(spacing: 24) {
                        ForEach(course.locations) { location in
                            Button(action: {
                                openMapForPlace(latitude: location.latitude, longitude: location.longitude)
                            }) {
                                Image(location.imageName)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(height: 130)
                                    .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                                    .shadow(radius: 8)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 16)
                                            .fill(Color.black.opacity(0.25))
                                    )
                                    .overlay(
                                        Text(location.name)
                                            .font(.headline)
                                            .foregroundColor(.white)
                                            .padding(12),
                                        alignment: .bottomLeading
                                    )
                                    .padding(.horizontal)
                            }
                        }
                    }
                    .padding(.top, 12)
                }
                Spacer()
            }
            .padding(.top)
        }
        .navigationBarBackButtonHidden(false)
    }

    func openMapForPlace(latitude: Double, longitude: Double) {
        let urlStr = "http://maps.apple.com/?ll=\(latitude),\(longitude)"
        if let url = URL(string: urlStr) {
            UIApplication.shared.open(url)
        }
    }
}

@available(iOS 26.0, *)
struct LocationsView_Previews: PreviewProvider {
    static var previews: some View {
        LocationsView(course: categoriesData.first!.courses.first!)
    }
}
