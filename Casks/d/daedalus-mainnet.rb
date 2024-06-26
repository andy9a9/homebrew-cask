cask "daedalus-mainnet" do
  version "5.3.1,66691,f14275aa5"
  sha256 "2596b12a89121cdbaa60b46b2f13085b6cd7c975ac82059ed0d0c4c86d0e3b7a"

  url "https://update-cardano-mainnet.iohk.io/daedalus-#{version.csv.first}-#{version.csv.second}-mainnet-#{version.csv.third}-x86_64-darwin.pkg",
      verified: "update-cardano-mainnet.iohk.io/"
  name "Daedalus Mainnet"
  desc "Cryptocurrency wallet for ada on the Cardano blockchain"
  homepage "https://daedaluswallet.io/"

  livecheck do
    url "https://update-cardano-mainnet.iohk.io/daedalus-latest-version.json"
    regex(%r{/daedalus[._-](\d+(?:\.\d+)+)[._-](\d+)[._-]mainnet[._-](\h+)[._-]x86_64[._-]darwin\.pkg}i)
    strategy :page_match do |page, regex|
      page.scan(regex).map { |match| "#{match[0]},#{match[1]},#{match[2]}" }
    end
  end

  auto_updates true
  depends_on macos: ">= :high_sierra"

  pkg "daedalus-#{version.csv.first}-#{version.csv.second}-mainnet-#{version.csv.third}-x86_64-darwin.pkg"

  uninstall pkgutil: "org.Daedalusmainnet.pkg"

  zap trash: [
    "~/Library/Application Support/Daedalus Mainnet",
    "~/Library/Preferences/com.electron.daedalus-mainnet.plist",
    "~/Library/Saved Application State/com.electron.daedalus-mainnet.savedState",
  ]
end
