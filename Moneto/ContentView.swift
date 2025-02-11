import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var items: [Item]

    var body: some View {
        NavigationStack {
            VStack {
                Text("Hello !")
                    .font(.custom("MadimiOne-Regular", size: 100))
                    .frame(maxWidth: .infinity, alignment: .top)
                    .multilineTextAlignment(.center)
                    .padding(.top, 60)
                    .offset(y: 20)
                    .foregroundColor(.white)

                Spacer()

                Image("poche")
                    .resizable()
                    .scaledToFit()
                    .offset(y: 30)
                    .offset(x: -10)
                    .frame(width: 1000, height: 550)

                Spacer()

                GeometryReader { geometry in
                    NavigationLink(destination: NextView()) {
                        Text("Suivant")
                            .frame(width: 150, height: 20)
                            .padding()
                            .background(Color(hex: "#262626"))
                            .foregroundColor(.white)
                            .cornerRadius(34)
                            .font(.system(size: 28))
                            .overlay(
                                RoundedRectangle(cornerRadius: 34)
                                    .stroke(Color.white, lineWidth: 2)
                            )
                    }
                    .position(x: geometry.size.width / 2, y: geometry.size.height - 95)
                }
            }
            .background(Color(hex: "#262626"))
            .edgesIgnoringSafeArea(.all)
        }
    }
}

struct NextView: View {
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        NavigationStack {
            VStack {
                Text("Hello !")
                    .font(.custom("MadimiOne-Regular", size: 100))
                    .frame(maxWidth: .infinity, alignment: .top)
                    .multilineTextAlignment(.center)
                    .padding(.top, 60)
                    .offset(y: 20)
                    .foregroundColor(.white)

                Spacer()
                    .frame(width: nil, height: 100)

                NavigationLink(destination: AncienTableau()) {
                    Text("Anciens Tableaux")
                        .padding(.horizontal, 30)
                        .padding(.vertical, 15)
                        .background(Color(hex: "#262626"))
                        .foregroundColor(.white)
                        .cornerRadius(34)
                        .font(.system(size: 24))
                        .overlay(
                            RoundedRectangle(cornerRadius: 34)
                                .stroke(Color.white, lineWidth: 2)
                        )
                        .offset(y: -20)
                }

                Spacer()
                    .frame(width: nil, height: 70.0)

                NavigationLink(destination: NouveauTableau()) {
                    Text("Nouveau Tableau")
                        .padding(.horizontal, 30)
                        .padding(.vertical, 15)
                        .background(Color(hex: "#262626"))
                        .foregroundColor(.white)
                        .cornerRadius(34)
                        .font(.system(size: 24))
                        .overlay(
                            RoundedRectangle(cornerRadius: 34)
                                .stroke(Color.white, lineWidth: 2)
                        )
                        .offset(y: -20)
                }
                Spacer()

                Button(action: {
                    self.presentationMode.wrappedValue.dismiss()
                }) {
                    Text("Retour")
                        .padding(.horizontal, 20)
                        .padding(.vertical, -5)
                        .font(.system(size: 25))
                        .padding()
                        .background(Color(hex: "#262626"))
                        .foregroundColor(.white)
                        .cornerRadius(34)
                        .overlay(
                            RoundedRectangle(cornerRadius: 34)
                                .stroke(Color.white, lineWidth: 2)
                        )
                }.offset(y: -50)
            }
            .background(Color(hex: "#262626"))
            .edgesIgnoringSafeArea(.all)
            .navigationBarBackButtonHidden(true)
        }
    }
}

struct AncienTableau: View {
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        VStack {
            Text("Anciens\nTableaux !")
                .font(.custom("MadimiOne-Regular", size: 50))
                .frame(maxWidth: .infinity, alignment: .top)
                .multilineTextAlignment(.center)
                .padding(.top, 60)
                .offset(y: 20)
                .foregroundColor(.white)

            Spacer()
                .frame(width: nil, height: 100)

            Button("Nouveau ") {
                // Action du bouton ici
            }
            .padding(.horizontal, 30)
            .padding(.vertical, 15)
            .background(Color(hex: "#262626"))
            .foregroundColor(.white)
            .cornerRadius(34)
            .font(.system(size: 24))
            .overlay(
                RoundedRectangle(cornerRadius: 34)
                    .stroke(Color.white, lineWidth: 2)
            )
            .offset(y: -20)

            Spacer()
                .frame(width: nil, height: 70.0)

            Button("Coucou") {
                // Action du bouton ici
            }
            .padding(.horizontal, 30)
            .padding(.vertical, 15)
            .background(Color(hex: "#262626"))
            .foregroundColor(.white)
            .cornerRadius(34)
            .font(.system(size: 24))
            .overlay(
                RoundedRectangle(cornerRadius: 34)
                    .stroke(Color.white, lineWidth: 2)
            )
            .offset(y: -20)

            Spacer()

            Button(action: {
                self.presentationMode.wrappedValue.dismiss()
            }) {
                Image(systemName: "xmark")
                    .font(.system(size: 28))
                    .padding()
                    .background(Color(hex: "#262626"))
                    .foregroundColor(.white)
                    .cornerRadius(34)
                    .overlay(
                        RoundedRectangle(cornerRadius: 34)
                            .stroke(Color.white, lineWidth: 2)
                    )
            }.offset(y: -50)
        }
        .background(Color(hex: "#262626"))
        .edgesIgnoringSafeArea(.all)
        .navigationBarBackButtonHidden(true)
    }
}

struct Revenu: Codable, Equatable, Identifiable {
    var id = UUID()
    var nom: String
    var montant: String
    var icone: String
}

struct NouveauTableau: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var revenus: [Revenu] = []
    @State private var expandedIndex: Int? = nil

    @AppStorage("revenusData") private var revenusData: Data = Data()

    var body: some View {
        NavigationStack {
            VStack {
                Text("Définissez vos\n différents revenus")
                    .font(.custom("MadimiOne-Regular", size: 45))
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .padding(.top, 70)

                ScrollView {
                    VStack(spacing: 20) {
                        ForEach(revenus.indices, id: \.self) { index in
                            RevenuCardView(
                                revenu: $revenus[index],
                                isExpanded: expandedIndex == index,
                                onExpandToggle: {
                                    withAnimation {
                                        expandedIndex = (expandedIndex == index) ? nil : index
                                    }
                                },
                                onDelete: {
                                    revenus.remove(at: index)
                                    expandedIndex = nil
                                }
                            )
                        }

                        Button(action: {
                            revenus.append(Revenu(nom: "Nouveau revenu", montant: "", icone: "plus.circle"))
                        }) {
                            HStack {
                                Spacer()
                                Image(systemName: "plus")
                                    .font(.system(size: 30))
                                    .foregroundColor(.white)
                                Spacer()
                            }
                            .padding()
                            .background(
                                RoundedRectangle(cornerRadius: 15)
                                    .stroke(Color.white, style: StrokeStyle(lineWidth: 2, dash: [6]))
                            )
                        }
                    }
                    .onAppear {
                        revenus = loadRevenus()
                    }
                    .onChange(of: revenus) {
                        saveRevenus()
                    }
                    .padding()
                }

                HStack {
                    Button(action: {
                        self.presentationMode.wrappedValue.dismiss()
                    }) {
                        Image(systemName: "xmark.circle")
                            .font(.system(size: 40))
                            .foregroundColor(.white)
                            .padding()
                    }
                    Spacer()
                    Button(action: {
                        print("Validation effectuée")
                    }) {
                        Image(systemName: "checkmark.circle")
                            .font(.system(size: 40))
                            .foregroundColor(.white)
                            .padding()
                    }
                }.padding(.horizontal)
            }
            .background(Color(hex: "#262626"))
            .edgesIgnoringSafeArea(.all)
            .navigationBarBackButtonHidden(true)
        }
    }

    private func saveRevenus() {
        if let data = try? JSONEncoder().encode(revenus) {
            revenusData = data
        }
    }

    private func loadRevenus() -> [Revenu] {
        if let decoded = try? JSONDecoder().decode([Revenu].self, from: revenusData) {
            return decoded
        }
        return []
    }
}

struct RevenuCardView: View {
    @Binding var revenu: Revenu
    var isExpanded: Bool
    var onExpandToggle: () -> Void
    var onDelete: () -> Void

    @State private var isIconPickerVisible = false
    @State private var selectedColor: Color = .white

    let couleursDisponibles: [Color] = [.blue, .green, .red, .orange, .purple]
    let iconesDisponibles: [String] = [
        "dollarsign.circle",
        "cart",
        "house",
        "briefcase",
        "heart",
        "gamecontroller"
    ]

    var body: some View {
        VStack {
            HStack {
                Image(systemName: revenu.icone)
                    .foregroundColor(.white)
                    .padding()
                    .background(
                        Circle()
                            .fill(Color.black) // Remplit l'intérieur du rond
                    )
                    .onTapGesture {
                        isIconPickerVisible.toggle()
                    }
                VStack(alignment: .leading) {
                    Text(revenu.nom)
                        .font(.headline)
                        .foregroundColor(.white)
                    Text("\(revenu.montant) €")
                        .foregroundColor(.white)
                    
                }
                Spacer()
            }
            .padding()

            if isExpanded {
                Divider().background(Color.white)

                HStack {
                    Image(systemName: "pencil")
                        .foregroundColor(.white)
                    TextField("Montant (€)", text: $revenu.montant)
                        .foregroundColor(.white)
                        .keyboardType(.decimalPad)
                }
                .padding()
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.white, lineWidth: 1)
                )
                .padding(.horizontal)

                HStack {
                    Text("Couleur")
                        .foregroundColor(.white)
                    Spacer()
                    ForEach(couleursDisponibles, id: \.self) { couleur in
                        Circle()
                            .fill(couleur)
                            .frame(width: 30, height: 30)
                            .onTapGesture {
                                // Ajoutez ici la logique pour changer la couleur de l'icône
                            }
                    }
                }
                .padding()

                Button(action: onDelete) {
                    Text("Supprimer")
                        .font(.headline)
                        .foregroundColor(.red)
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.red, lineWidth: 2)
                        )
                }
                .padding()
            }
        }
        .background(Color(hex: "#2F2F2F"))
        .cornerRadius(15)
        .shadow(color: .black.opacity(0.2), radius: 10, x: 0, y: 5)
        .onTapGesture {
            onExpandToggle()
        }
        .sheet(isPresented: $isIconPickerVisible) {
            IconPickerView(selectedIcon: $revenu.icone, iconesDisponibles: iconesDisponibles)
        }
    }
}

struct IconPickerView: View {
    @Binding var selectedIcon: String
    let iconesDisponibles: [String]
    let couleursDisponibles: [Color] = [.red, .blue, .green, .yellow, .purple, .orange, .pink, .gray]
    @State private var selectedColor: Color? = nil

    var body: some View {
        VStack {
            Text("Icones")
                .font(.headline)
                .padding()

            LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 4)) {
                ForEach(iconesDisponibles, id: \.self) { icone in
                    Image(systemName: icone)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 50, height: 50)
                        .padding(5)
                        .background(selectedIcon == icone ? Color.gray.opacity(0.3) : Color.clear)
                        .cornerRadius(8)
                        .onTapGesture {
                            selectedIcon = icone
                        }
                }

            }
            Text("Choisissez une couleur")
                            .font(.headline)
                            .padding()

                        LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 4)) {
                            ForEach(couleursDisponibles, id: \.self) { couleur in
                                Circle()
                                    .fill(couleur)
                                    .frame(width: 50, height: 50)
                                    .overlay(
                                        Circle()
                                            .stroke(selectedColor == couleur ? Color.black : Color.clear, lineWidth: 3)
                                    )
                                    .onTapGesture {
                                        selectedColor = couleur
                                    }
                            }
                        }
                        .padding()

            Spacer()
        }
        .background(Color(hex: "#262626"))
        .cornerRadius(15)
        .padding()
    }
}

//======================AUTRES============================

// Affichage de la preview
#Preview {
    ContentView()
        .modelContainer(for: Item.self, inMemory: true)
}

// Gestion des couleurs hexadécimales
extension Color {
    init(hex: String) {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)

        if hexSanitized.hasPrefix("#") {
            hexSanitized.removeFirst()
        }

        var rgb: UInt64 = 0
        Scanner(string: hexSanitized).scanHexInt64(&rgb)

        let red = Double((rgb >> 16) & 0xFF) / 255.0
        let green = Double((rgb >> 8) & 0xFF) / 255.0
        let blue = Double(rgb & 0xFF) / 255.0

        self.init(red: red, green: green, blue: blue)
    }
}
