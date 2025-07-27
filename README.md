## Installation

1. [Download the latest release](https://github.com/feelthatvib3/cvault/releases);
2. Unzip the file;
3. Move `cvault.app` to your `/Applications` folder (optional, but recommended);
4. Run the following command in Terminal to allow macOS to launch the app:

```sh
xattr -d com.apple.quarantine cvault.app
```

### Why do you need the command?

> macOS blocks apps that aren’t notarized or downloaded via the App Store. This command removes the quarantine flag and lets you run it.
