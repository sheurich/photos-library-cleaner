# SPEC.md: Photos Library Cleaner

## 1. Overview
The goal of Photos Library Cleaner is to develop a native macOS/iOS application that automates the cleanup and organization of the Apple Photos library. The app will:
- **Delete blurry photos**
- **Delete low-quality/bad photos and videos**
- **Remove redundant and duplicate media**
- **Coalesce similar shots (multiple captures of the same scene) into one or two best selections**
- **Identify and remove temporary task-related photos/videos (e.g. screenshots, documents)**
- **Organize the remaining photos into events with appropriate labels and dates**

The application must work with Apple-supported APIs (preferably via PhotoKit) to ensure long-term stability and App Store compliance. It should support both fully automated cleanup and a manual review mode with an intuitive UI.

---

## 2. Design Goals
- **Automation with User Control:** Allow both automatic cleanup and manual approval with a responsive UI.
- **Data Safety:** All deletions must be non-destructive (utilizing the Photos “Recently Deleted” feature) and support an undo process.
- **ML-Based Analysis:** Use on-device ML (via Core ML and Vision) to detect blur, assess image quality, and perform duplicate/similarity analysis. Optionally, provide cloud-based analysis as an opt-in.
- **Native Integration:** Use Apple’s Photos framework for accessing and modifying the library and, if necessary, CloudKit for iCloud integration.
- **Public Distribution Potential:** Initially for personal use but designed with future public release in mind, following Apple’s guidelines.

---

## 3. Technology Stack
- **Language & Framework:** Swift with SwiftUI (for both macOS and iOS).
- **Library Access:** PhotoKit (PHPhotoLibrary, PHAsset, PHAssetCollection, PHImageManager).
- **ML & Image Analysis:** Core ML and Vision frameworks.
- **Data Storage:** UserDefaults for simple settings; optional Core Data or file-based cache for derived data.
- **Error Handling & Logging:** Use built-in Swift error handling with detailed logs.
- **Optional Cloud Integration:** CloudKit for iCloud access (if needed) and optionally secure cloud ML inference.

---

## 4. System Architecture

### 4.1. Components
- **Photo Library Access Layer:**  
  - Fetch assets using PhotoKit.
  - Retrieve metadata (timestamps, location, media type).
  - Request thumbnails/full-resolution images as needed.
  - Commit changes (deletions, album creation) via `PHPhotoLibrary.shared().performChanges`.

- **ML Analysis Module:**  
  - **Blurry Photo Detection:** Use a Laplacian variance method or a Core ML model to score image sharpness.
  - **Duplicate/Similarity Detection:** Compute image feature vectors using Vision’s featureprint API and cluster similar photos (using thresholds/clustering algorithms).
  - **Temporary Content Detection:** Identify screenshots, documents, and other temporary photos using metadata and optional OCR.
  - **Event Clustering:** Group photos by time/location and propose event albums.

- **User Interface (UI) Module:**  
  - **Dashboard:** Present summary statistics (e.g., number of suggested deletions, event albums).
  - **Review Screens:** Allow users to review each category (blurry, duplicates, temporary) with options to accept/reject suggestions.
  - **Event Organizer:** Enable drag-and-drop album grouping, labeling, and dating.
  - **Undo/Confirmation:** Ensure all destructive actions are reversible via the Photos “Recently Deleted” feature.

- **Logic & Orchestration:**  
  - Combine ML results and user preferences to form a coherent set of suggestions.
  - Coordinate background analysis and UI updates.
  - Handle errors and log actions.

---

## 5. Implementation Specification

### 5.1. API Integration
- **PhotoKit:**  
  - Request user permission and fetch assets with PHAsset.
  - Use PHImageManager for image retrieval.
  - Execute modifications (deletions, album creation) inside `PHPhotoLibrary.performChanges` blocks.

- **Core ML/Vision:**  
  - Integrate a Core ML model (or heuristic) for blur detection.
  - Use `VNGenerateImageFeaturePrintRequest` for computing image feature vectors.
  - Implement clustering and scoring for duplicates and similar photos.
  - Optionally apply OCR via `VNRecognizeTextRequest` for detecting temporary content.

### 5.2. UI and User Flow
- **Modes:**  
  - **Automatic Mode:** Summarize suggested actions and execute with a single confirmation.
  - **Manual Mode:** Provide a review interface with categorized lists (blurry, duplicates, temporary, events) for user approval.
- **Event Album Creation:**  
  - Cluster photos by creation date and geolocation.
  - Suggest event names (using date ranges and reverse geocoding if available) and allow user editing.
- **User Confirmation & Undo:**  
  - Display final confirmation and warning about deletions.
  - Ensure deletions route to “Recently Deleted” for recovery.

### 5.3. Error Handling & Performance
- Use background threads (GCD/OperationQueue) for ML and image processing tasks.
- Provide progress indicators during long-running analyses.
- Gracefully handle PhotoKit errors (e.g., permissions, network issues for iCloud assets).

---

## 6. Deployment Considerations
- **For Personal Use:**  
  - Sideload via Xcode or TestFlight.
- **For Public Distribution:**  
  - Adhere to App Store guidelines.
  - Ensure the app is sandboxed and complies with privacy regulations.
  - Provide comprehensive documentation and unit tests.

---

## 7. Privacy and Security
- **Local Processing:** All ML analysis is performed on-device unless the user opts in for cloud processing.
- **Permission Transparency:** Clearly describe Photos access in the Info.plist.
- **Data Safety:** Use the Photos “Recently Deleted” album for non-permanent deletion.
- **Secure Optional Cloud Integration:** Use HTTPS and explicit user consent for any data sent off-device.

---

## 8. Deliverables
- A fully functional Xcode project with detailed inline documentation.
- A comprehensive README describing setup, configuration, and usage.
- Unit tests for critical components (e.g., duplicate detection, blur detection).
- Clear instructions for potential future public distribution.

---

## Additional Guidance for Implementation
The developer should actively search for high-quality code samples and reference implementations. Good sources include:
- **GitHub:** Look for open-source projects that use PhotoKit, SwiftUI, or Core ML/Vision for image analysis.
- **GitLab:** Find projects or components that align with parts of this project.
- **Apple Developer Documentation:** Use Apple's official guides, sample code, and WWDC videos for best practices with PhotoKit, SwiftUI, Core ML, and Vision.
- **Other reputable sources:** Developer blogs, Medium articles, and StackOverflow answers relevant to similar features.
Review these resources carefully, and feel free to copy or adapt proven techniques and code snippets to ensure robust, efficient, and well-tested components.