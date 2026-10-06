cask "countdown" do
  version "1.0.0"
  sha256 "4ca275f1315940db637e2ba3f7ec0fbda171b80979e016031d935ccd4cfc9f66"

  url "https://github.com/larjudge/countdown/releases/download/v#{version}/Countdown-#{version}.zip"
  name "Countdown"
  desc "Countdown timer that lives in the menu bar"
  homepage "https://github.com/larjudge/countdown"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: ">= :sequoia"

  app "Countdown.app"

  # The app is ad-hoc signed rather than notarized, so clear the quarantine
  # flag to let it launch without a Gatekeeper prompt.
  postflight do
    system_command "/usr/bin/xattr",
                   args: ["-dr", "com.apple.quarantine", "#{appdir}/Countdown.app"]
  end

  uninstall quit:       "dev.lar.Countdown",
            login_item: "Countdown"

  zap trash: "~/Library/Preferences/dev.lar.Countdown.plist"
end
