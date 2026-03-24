//
//  ContentView.swift
//  swiftui material components proto
//
//  Material Design 3 component showcase for MattiUI.
//  Demonstrates all M3 components with SwiftUI previews.
//

import SwiftUI
import MattiUI

// MARK: - ContentView (root navigation)

struct ContentView: View {
    @State private var selectedTab = 0

    var body: some View {
        VStack(spacing: 0) {
            // Content area
            Group {
                switch selectedTab {
                case 0: ButtonsShowcaseView()
                case 1: CardsAndChipsShowcaseView()
                case 2: InputsShowcaseView()
                default: MiscShowcaseView()
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)

            // M3 NavigationBar
            NavigationBar(
                items: [
                    NavigationBarItem(icon: Image(systemName: "button.horizontal"), selectedIcon: Image(systemName: "button.horizontal.fill"), label: "Buttons"),
                    NavigationBarItem(icon: Image(systemName: "rectangle.on.rectangle"), selectedIcon: Image(systemName: "rectangle.fill.on.rectangle.fill"), label: "Cards"),
                    NavigationBarItem(icon: Image(systemName: "keyboard"), selectedIcon: Image(systemName: "keyboard.fill"), label: "Inputs"),
                    NavigationBarItem(icon: Image(systemName: "sparkles"), label: "Misc"),
                ],
                selectedIndex: $selectedTab
            )
        }
        .materialTheme(.light)
        .ignoresSafeArea(edges: .bottom)
    }
}

// MARK: - Buttons Showcase

struct ButtonsShowcaseView: View {
    var body: some View {
        ScrollView {
            LazyVStack(alignment: .leading, spacing: 0) {
                TopAppBar(title: "Buttons & FAB")

                SectionHeader("Filled Button")
                ShowcaseRow {
                    FilledButton("Save") {}
                    FilledButton("Upload", icon: Image(systemName: "arrow.up")) {}
                }

                SectionHeader("Outlined Button")
                ShowcaseRow {
                    OutlinedButton("Cancel") {}
                    OutlinedButton("Share", icon: Image(systemName: "square.and.arrow.up")) {}
                }

                SectionHeader("Text Button")
                ShowcaseRow {
                    TextButton("Learn more") {}
                    TextButton("Open", icon: Image(systemName: "arrow.right")) {}
                }

                SectionHeader("Elevated Button")
                ShowcaseRow {
                    ElevatedButton("Reply") {}
                    ElevatedButton("Add Photo", icon: Image(systemName: "photo")) {}
                }

                SectionHeader("Filled Tonal Button")
                ShowcaseRow {
                    FilledTonalButton("Explore") {}
                    FilledTonalButton("Location", icon: Image(systemName: "location.fill")) {}
                }

                SectionHeader("Disabled States")
                ShowcaseRow {
                    FilledButton("Disabled") {}.disabled(true)
                    OutlinedButton("Disabled") {}.disabled(true)
                    TextButton("Disabled") {}.disabled(true)
                }

                SectionHeader("Floating Action Buttons")
                HStack(spacing: 20) {
                    VStack(spacing: 4) {
                        SmallFloatingActionButton(icon: Image(systemName: "pencil")) {}
                        Text("Small").font(.caption2)
                    }
                    VStack(spacing: 4) {
                        FloatingActionButton(icon: Image(systemName: "plus")) {}
                        Text("FAB").font(.caption2)
                    }
                    VStack(spacing: 4) {
                        LargeFloatingActionButton(icon: Image(systemName: "camera")) {}
                        Text("Large").font(.caption2)
                    }
                }
                .frame(maxWidth: .infinity)
                .padding()

                SectionHeader("Extended FAB")
                ShowcaseRow {
                    ExtendedFloatingActionButton("Compose", icon: Image(systemName: "pencil")) {}
                    ExtendedFloatingActionButton("New Trip") {}
                }

                MaterialDivider().padding(.top, 16)
            }
        }
    }
}

// MARK: - Cards & Chips Showcase

struct CardsAndChipsShowcaseView: View {
    @State private var filter1 = true
    @State private var filter2 = false
    @State private var filter3 = false
    @State private var chips = ["SwiftUI", "Kotlin", "Material 3"]

    var body: some View {
        ScrollView {
            LazyVStack(alignment: .leading, spacing: 0) {
                TopAppBar(title: "Cards & Chips")

                SectionHeader("Elevated Card")
                ElevatedCard {
                    SampleCardContent(title: "Elevated Card", subtitle: "Uses a drop shadow for elevation")
                }
                .padding(.horizontal)
                .padding(.bottom, 8)

                SectionHeader("Filled Card")
                FilledCard {
                    SampleCardContent(title: "Filled Card", subtitle: "Uses surfaceVariant color, no shadow")
                }
                .padding(.horizontal)
                .padding(.bottom, 8)

                SectionHeader("Outlined Card")
                OutlinedCard {
                    SampleCardContent(title: "Outlined Card", subtitle: "Uses a border stroke, no shadow")
                }
                .padding(.horizontal)
                .padding(.bottom, 8)

                SectionHeader("Assist Chips")
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 8) {
                        AssistChip("Set reminder", icon: Image(systemName: "bell")) {}
                        AssistChip("Directions", icon: Image(systemName: "location")) {}
                        AssistChip("Add to calendar", icon: Image(systemName: "calendar.badge.plus")) {}
                    }
                    .padding(.horizontal)
                }
                .padding(.bottom, 8)

                SectionHeader("Filter Chips")
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 8) {
                        FilterChip("Sci-Fi", isSelected: $filter1)
                        FilterChip("Drama", isSelected: $filter2)
                        FilterChip("Comedy", isSelected: $filter3)
                    }
                    .padding(.horizontal)
                }
                .padding(.bottom, 8)

                SectionHeader("Input Chips (tap × to remove)")
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 8) {
                        ForEach(chips, id: \.self) { chip in
                            InputChip(chip, icon: Image(systemName: "tag")) {
                                chips.removeAll { $0 == chip }
                            }
                        }
                    }
                    .padding(.horizontal)
                }
                .padding(.bottom, 8)

                SectionHeader("Suggestion Chips")
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 8) {
                        SuggestionChip("Reply all", icon: Image(systemName: "arrowshape.turn.up.left.2")) {}
                        SuggestionChip("Forward") {}
                        SuggestionChip("Snooze", icon: Image(systemName: "moon")) {}
                    }
                    .padding(.horizontal)
                }
                .padding(.bottom, 16)

                MaterialDivider()
            }
        }
    }
}

// MARK: - Inputs Showcase

struct InputsShowcaseView: View {
    @State private var email = ""
    @State private var password = ""
    @State private var username = "johndoe"
    @State private var switchOn = true
    @State private var switchOff = false
    @State private var check1 = true
    @State private var check2 = false
    @State private var radioSelection = "Option B"
    let radioOptions = ["Option A", "Option B", "Option C"]

    var body: some View {
        ScrollView {
            LazyVStack(alignment: .leading, spacing: 0) {
                TopAppBar(title: "Inputs & Selection")

                SectionHeader("Filled Text Field")
                VStack(spacing: 12) {
                    FilledTextField("Email address", text: $email,
                                    leadingIcon: Image(systemName: "envelope"),
                                    supportingText: "We'll never share your email")
                    FilledTextField("Password", text: $password, isSecure: true,
                                    trailingIcon: Image(systemName: "eye.slash"))
                }
                .padding(.horizontal)
                .padding(.bottom, 12)

                SectionHeader("Outlined Text Field")
                VStack(spacing: 12) {
                    OutlinedTextField("Username", text: $username,
                                      leadingIcon: Image(systemName: "person"))
                    OutlinedTextField("Disabled", text: .constant(""))
                        .disabled(true)
                }
                .padding(.horizontal)
                .padding(.bottom, 12)

                SectionHeader("Switch")
                VStack(spacing: 4) {
                    HStack {
                        Text("Airplane mode")
                        Spacer()
                        MaterialSwitch(isOn: $switchOn, thumbIcon: Image(systemName: "checkmark"))
                    }
                    HStack {
                        Text("Bluetooth")
                        Spacer()
                        MaterialSwitch(isOn: $switchOff)
                    }
                }
                .padding(.horizontal)
                .padding(.bottom, 12)

                SectionHeader("Checkbox")
                VStack(alignment: .leading, spacing: 0) {
                    HStack { MaterialCheckbox(isChecked: $check1); Text("Enable notifications") }
                    HStack { MaterialCheckbox(isChecked: $check2); Text("Dark mode") }
                    HStack { MaterialCheckbox(isChecked: .constant(true)).disabled(true); Text("Disabled (checked)").foregroundColor(.secondary) }
                }
                .padding(.horizontal)
                .padding(.bottom, 12)

                SectionHeader("Radio Button")
                MaterialRadioGroup(options: radioOptions, selection: $radioSelection) { $0 }
                    .padding(.horizontal)
                    .padding(.bottom, 16)

                MaterialDivider()
            }
        }
    }
}

// MARK: - Misc Showcase

struct MiscShowcaseView: View {
    @State private var showDialog = false
    @State private var snack: SnackbarData? = nil
    @State private var progress = 0.6

    var body: some View {
        ScrollView {
            LazyVStack(alignment: .leading, spacing: 0) {
                TopAppBar(title: "Progress, Badges & More")

                SectionHeader("Linear Progress Indicator")
                VStack(spacing: 16) {
                    LinearProgressIndicator()
                    LinearProgressIndicator(progress: progress)
                    Slider(value: $progress, in: 0...1)
                        .tint(Color(m3hex: "#6750A4"))
                }
                .padding(.horizontal)
                .padding(.bottom, 12)

                SectionHeader("Circular Progress Indicator")
                HStack(spacing: 32) {
                    VStack(spacing: 8) {
                        CircularProgressIndicator()
                        Text("Indeterminate").font(.caption2)
                    }
                    VStack(spacing: 8) {
                        CircularProgressIndicator(progress: progress)
                        Text("Determinate").font(.caption2)
                    }
                    VStack(spacing: 8) {
                        CircularProgressIndicator(progress: 0.85, size: 64, strokeWidth: 6)
                        Text("Large").font(.caption2)
                    }
                }
                .frame(maxWidth: .infinity)
                .padding()
                .padding(.bottom, 12)

                SectionHeader("Badges")
                HStack(spacing: 32) {
                    VStack(spacing: 8) {
                        BadgedBox(badge: Badge()) {
                            Image(systemName: "bell").resizable().scaledToFit().frame(width: 28, height: 28)
                        }
                        Text("Dot").font(.caption2)
                    }
                    VStack(spacing: 8) {
                        BadgedBox(badge: Badge(count: 5)) {
                            Image(systemName: "envelope").resizable().scaledToFit().frame(width: 28, height: 28)
                        }
                        Text("Count").font(.caption2)
                    }
                    VStack(spacing: 8) {
                        BadgedBox(badge: Badge(count: 1200)) {
                            Image(systemName: "message").resizable().scaledToFit().frame(width: 28, height: 28)
                        }
                        Text("999+").font(.caption2)
                    }
                }
                .frame(maxWidth: .infinity)
                .padding()
                .padding(.bottom, 12)

                SectionHeader("Divider")
                VStack(spacing: 12) {
                    Text("Full-width").frame(maxWidth: .infinity, alignment: .leading)
                    MaterialDivider()
                    Text("Inset (16 pt)").frame(maxWidth: .infinity, alignment: .leading)
                    MaterialDivider(inset: 16)
                    HStack(spacing: 16) {
                        Text("Vertical")
                        MaterialDivider(isVertical: true, length: 20)
                        Text("Divider")
                    }
                }
                .padding(.horizontal)
                .padding(.bottom, 12)

                SectionHeader("Alert Dialog")
                FilledButton("Show Alert Dialog") { showDialog = true }
                    .padding(.horizontal)
                    .padding(.bottom, 12)

                SectionHeader("Snackbar")
                VStack(spacing: 8) {
                    FilledButton("Simple Snackbar") {
                        snack = SnackbarData(message: "Connection restored")
                    }
                    FilledTonalButton("Snackbar with Action") {
                        snack = SnackbarData(message: "Item deleted", actionLabel: "Undo")
                    }
                }
                .padding(.horizontal)
                .padding(.bottom, 12)

                SectionHeader("Top App Bar variants")
                VStack(spacing: 2) {
                    TopAppBar(title: "Small App Bar",
                              navigationIcon: Image(systemName: "chevron.left"),
                              actions: [TopAppBarAction(icon: Image(systemName: "ellipsis.circle"), action: {})])
                    MaterialDivider()
                    CenterAlignedTopAppBar(
                        title: "Centered",
                        navigationIcon: Image(systemName: "chevron.left"),
                        actions: [TopAppBarAction(icon: Image(systemName: "magnifyingglass"), action: {})]
                    )
                    MaterialDivider()
                    MediumTopAppBar(title: "Medium App Bar",
                                    navigationIcon: Image(systemName: "chevron.left"))
                    MaterialDivider()
                    LargeTopAppBar(title: "Large App Bar",
                                   navigationIcon: Image(systemName: "chevron.left"))
                }
                .padding(.bottom, 16)

                MaterialDivider()
            }
        }
        .overlay {
            AlertDialog(
                isPresented: $showDialog,
                icon: Image(systemName: "trash"),
                title: "Delete item?",
                text: "This action cannot be undone. The item will be permanently removed.",
                confirmButton: AlertDialogButton(label: "Delete", role: .destructive) { showDialog = false },
                dismissButton: AlertDialogButton(label: "Cancel") { showDialog = false }
            )
        }
        .snackbar(data: $snack, onAction: { print("Snackbar action tapped") })
    }
}

// MARK: - Reusable helpers

private struct SectionHeader: View {
    let title: String
    init(_ title: String) { self.title = title }

    var body: some View {
        Text(title)
            .font(.system(size: 12, weight: .semibold))
            .foregroundColor(.secondary)
            .textCase(.uppercase)
            .padding(.horizontal)
            .padding(.top, 20)
            .padding(.bottom, 8)
    }
}

private struct ShowcaseRow<Content: View>: View {
    let content: () -> Content
    init(@ViewBuilder content: @escaping () -> Content) { self.content = content }

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 12) { content() }
                .padding(.horizontal)
        }
        .padding(.bottom, 8)
    }
}

private struct SampleCardContent: View {
    let title: String
    let subtitle: String

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Image(systemName: "photo")
                .resizable()
                .scaledToFit()
                .frame(height: 80)
                .frame(maxWidth: .infinity)
                .background(Color.gray.opacity(0.15))
                .clipped()
            VStack(alignment: .leading, spacing: 4) {
                Text(title).font(.headline)
                Text(subtitle).font(.subheadline).foregroundColor(.secondary)
            }
            .padding([.horizontal, .bottom])
        }
    }
}

// MARK: - Previews

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .materialTheme(.light)
            .previewDisplayName("M3 Showcase — Light")

        ContentView()
            .materialTheme(.dark)
            .previewDisplayName("M3 Showcase — Dark")
    }
}

// MARK: - Individual section previews

struct ButtonsShowcase_Previews: PreviewProvider {
    static var previews: some View {
        ButtonsShowcaseView()
            .materialTheme(.light)
            .previewDisplayName("Buttons Showcase — Light")
    }
}

struct CardsChips_Previews: PreviewProvider {
    static var previews: some View {
        CardsAndChipsShowcaseView()
            .materialTheme(.light)
            .previewDisplayName("Cards & Chips — Light")
    }
}

struct Inputs_Previews: PreviewProvider {
    static var previews: some View {
        InputsShowcaseView()
            .materialTheme(.light)
            .previewDisplayName("Inputs & Selection — Light")
    }
}

struct Misc_Previews: PreviewProvider {
    static var previews: some View {
        MiscShowcaseView()
            .materialTheme(.light)
            .previewDisplayName("Progress, Badges & More — Light")
    }
}
