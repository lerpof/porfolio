# Translation Template

Here's the template of a JSON translation file:

```json
{
  // Personal Information
  "name": "Leonardo Lazzari", // Full name (first name and last name)
  "description": "Mobile Software Imagineer", // Your professional title or role (e.g., Software Engineer)
  "subDescription": "Flutter Enthusiast", // A brief description of your interests or focus

  // Contact Details
  "contacts": [
    {
      "tooltip": "Github", // Tooltip displayed when hovering or long-pressing the contact icon button
      "url": "https://github.com/lerpof", // URL to open when the contact icon button is tapped, accepts various URL schemes (sms, tel, mailto, https, file)
      "icon": {
        "assetName": "assets/images/logos/software-development/github.svg", // SVG asset path, can be obtained from https://github.com/chouhan-rahul/icons_plus/tree/main/lib/src. If the codePoint and the fontFamily are used, this property must be null.
        "codePoint": "0xefb7", // Unicode code point for the icon prefixed with "0x" for hexadecimal, can be obtained from https://github.com/chouhan-rahul/icons_plus/tree/main/lib/src. If the assetName is used, this property must be null.
        "fontFamily": "FontAwesome", // Font family for the icon (e.g., FontAwesome), can be obtained from https://github.com/chouhan-rahul/icons_plus/tree/main/lib/src. If the assetName is used, this property must be null.
        "color": "0xffffffff" // Hexadecimal color for the icon.
      }
    }
  ],

  // Resumes
  "resumes": [
    {
      "languageCode": "en", // Language code matching one defined in "languages" key
      "url": "https://drive.google.com/file/d/1_I-4YxnvL0kLgWF3c_C4qNUZtUuzkPV2/view?usp=drive_link" // URL to open when the corresponding resume language tile is tapped
    }
  ],

  // About Me
  "aboutDescription": "Hi! I’m Leonardo, a Mobile App Developer. I graduated in Computer Science and have a strong passion for programming and technology. I specialize in developing iOS applications with SwiftUI and UIKit, as well as cross-platform applications with Flutter.\nI am always looking for new challenges and opportunities to grow professionally. Feel free to contact me!", // about text that is displayed in "About Me" section

  // Experiences
  "experiences": [
    {
      "role": "Mobile App Developer", // Your role title or role
      "company": "CGM Consulting", // Name of the company you worked at
      "description": "Development of mobile applications in the telecommunications field, particularly for managing home networks by interfacing with routers and various network devices.\nDevelopment of Android, iOS, and Web applications using Flutter.", // Description of your role
      "isPresent": true, // Indicates whether the role is your current position
      "startYear": 2022, // Starting year of the role
      "startMonth": 3, // Starting month of the role// Ending month of the role (if applicable)
      "technologies": [
        {
          "name": "Flutter", // Name of the technology used in this role experience
          "icon": {
            "assetName": "assets/images/logos/software-development/flutter.svg" // SVG asset path, can be obtained from https://github.com/chouhan-rahul/icons_plus/tree/main/lib/src. If the codePoint and the fontFamily are used, this property must be null.
          }
        }
      ],
    }
  ],
  "present": "Present", // Text indicating the experience is current

  // Projects
  "projects": [
    {
      "name": "Portfolio", // Name of the project
      "description": "Portfolio is a mobile application developed with Flutter that allows you to view my portfolio and my projects.", // Description of the project
      "url": "https://github.com/AladdineDev/portfolio#readme", // URL to open when the project card is tapped
      "icon": {
        "assetName": "assets/images/logos/software-development/github.svg", // SVG asset path, can be obtained from https://github.com/chouhan-rahul/icons_plus/tree/main/lib/src. If the codePoint and the fontFamily are used, this property must be null.
        "codePoint": "0xefb7", // Unicode code point for the icon prefixed with "0x" for hexadecimal, can be obtained from https://github.com/chouhan-rahul/icons_plus/tree/main/lib/src. If the assetName is used, this property must be null.
        "fontFamily": "FontAwesome", // Font family for the icon (e.g., FontAwesome), can be obtained from https://github.com/chouhan-rahul/icons_plus/tree/main/lib/src. If the assetName is used, this property must be null.
        "color": "0xffffffff" // Hexadecimal color for the icon.
      },
      "screenshotPath": "assets/images/portfolio.png", // screenshot asset path of the project
      "technologies": [
        "Flutter" // Technologies used in this project
      ],
    }
  ],

  // Supported Languages
  "languages": [
    {
      "code": "en", // Language code
      "name": "English", // Display name of the language
      "nativeName": "English", // Native name of the language
      "icon": {
        // Country flag
        "assetName": "assets/images/logos/flags/united-states-of-america.svg" // SVG asset path, can be obtained from https://github.com/chouhan-rahul/icons_plus/blob/main/lib/src/flag.dart. If the codePoint and the fontFamily are used, this property must be null.
      }
    }
  ],

  // Bottom banner
  "bottomBanner": {
    "message": "Lazzari Leonardo - Mobile App Developer", // Text at the beginning of the "displayLink" part
  },

  // Navigation and Section Titles
  "portfolio": "Portfolio", // Title for the app bar
  "homeSectionTitle": "Home", // Text for the home section
  "aboutSectionTitle": "About", // Text for the about section
  "aboutSectionTitleAlt": "About Me", // Alternative text for the about section
  "experienceSectionTitle": "Experience", // Text for the experience section
  "projectsSectionTitle": "Projects", // Text for the projects section
  "resume": "Resume", // Text for the resume button
  "downloadResume": "Download resume", // Title for the resume download dialog

  // Error Messages
  "openUrlError": "Could not open the url" // url error
}
```
