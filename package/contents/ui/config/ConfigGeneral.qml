import QtQuick 2.0
import QtQuick.Controls 1.0
import QtQuick.Layouts 1.0

import ".."
import "../lib"

ConfigPage {
	id: page
	showAppletVersion: true

	property string cfg_clickCommand
	property string cfg_clickCommandID
	property string cfg_forceDis
	property string cfg_advancedUnlock
	property string cfg_newVersion
	property string cfg_forceSize
    property alias cfg_customSize: customSize.text

	ExclusiveGroup { id: clickCommandGroup }
	ExclusiveGroup { id: clickCommandGroupID }
	ExclusiveGroup { id: forceDisGroup }
	ExclusiveGroup { id: advancedUnlockGroup }
	ExclusiveGroup { id: newVersionGroup }
	ExclusiveGroup { id: forceSizeGroup }
    
	ConfigSection {
		label: i18n("Click Action")

		RadioButton {
			text: i18nd("kwin_effects", "Hide/Unhide Panel")
			checked: cfg_clickCommand == 'HideUnhide'
			exclusiveGroup: clickCommandGroup
			onClicked: cfg_clickCommand = 'HideUnhide'
		}
		RadioButton {
			text: i18nd("kwin_effects", "Unhide Panel And Auto Hide After 10 Sec")
			checked: cfg_clickCommand == 'HideAutoUnhide'
			exclusiveGroup: clickCommandGroup
			onClicked: cfg_clickCommand = 'HideAutoUnhide'
		}
	}
    
	ConfigSection {
		label: i18n("Targeted Panel")

		RadioButton {
			text: i18nd("kwin_effects", "Hide/Unhide Panel ID 0")
			checked: cfg_clickCommandID == 'PanelID0'
			exclusiveGroup: clickCommandGroupID
			onClicked: cfg_clickCommandID = 'PanelID0'
		}
		RadioButton {
			text: i18nd("kwin_effects", "Hide/Unhide Panel ID 1")
			checked: cfg_clickCommandID == 'PanelID1'
			exclusiveGroup: clickCommandGroupID
			onClicked: cfg_clickCommandID = 'PanelID1'
		}
		RadioButton {
			text: i18nd("kwin_effects", "Hide/Unhide Panel ID 2")
			checked: cfg_clickCommandID == 'PanelID2'
			exclusiveGroup: clickCommandGroupID
			onClicked: cfg_clickCommandID = 'PanelID2'
		}
		RadioButton {
			text: i18nd("kwin_effects", "Hide/Unhide Panel ID 3")
			checked: cfg_clickCommandID == 'PanelID3'
			exclusiveGroup: clickCommandGroupID
			onClicked: cfg_clickCommandID = 'PanelID3'
		}
		RadioButton {
			text: i18nd("kwin_effects", "Hide/Unhide Panel ID 4")
			checked: cfg_clickCommandID == 'PanelID4'
			exclusiveGroup: clickCommandGroupID
			onClicked: cfg_clickCommandID = 'PanelID4'
		}
		RadioButton {
			text: i18nd("kwin_effects", "Hide/Unhide Panel ID 5")
			checked: cfg_clickCommandID == 'PanelID5'
			exclusiveGroup: clickCommandGroupID
			onClicked: cfg_clickCommandID = 'PanelID5'
		}
		RadioButton {
			text: i18nd("kwin_effects", "Hide/Unhide Panel ID 6")
			checked: cfg_clickCommandID == 'PanelID6'
			exclusiveGroup: clickCommandGroupID
			onClicked: cfg_clickCommandID = 'PanelID6'
		}
        
	}
    
	ConfigSection {
		label: i18n("Button Icon")

		ConfigIcon {
			configKey: 'icon'
			defaultValue: 'panel-24px'
			presetValues: [
				'panel-24px',
				'panel-22px',
				'panel-16px',
			]
		}
	}
    
	ConfigSection {
		label: i18n("Working Mode - Effect")

		RadioButton {
			text: i18nd("kwin_effects", "Force the panel to popup (useful when the panel is set to autohide) \nThe panel blink on the opposite side")
			checked: cfg_forceDis == 'True'
			exclusiveGroup: forceDisGroup
			onClicked: cfg_forceDis = 'True'
		}
		RadioButton {
			text: i18nd("kwin_effects", "Just change the size of the panel without forcing it to be displayed \nThe panel does not blink on the opposite side")
			checked: cfg_forceDis == 'False'
			exclusiveGroup: forceDisGroup
			onClicked: cfg_forceDis = 'False'
		}
	}
    
	ConfigSection {
		label: i18n("Working Mode - Toggle")

		RadioButton {
			text: i18nd("kwin_effects", "Use a negative value to toggle the panel \nThe panel size is multiplied by '-1' to toggle \nThe panel need to be visible before setting this")
			checked: cfg_forceSize == 'False'
			exclusiveGroup: forceSizeGroup
			onClicked: cfg_forceSize = 'False'
		}        
		RadioButton {
			text: i18nd("kwin_effects", "Set the panel size to '0' when hiding and \nforce its size to specified value when unhiding\nThe panel size need to be specified")
			checked: cfg_forceSize == 'True'
			exclusiveGroup: forceSizeGroup
			onClicked: cfg_forceSize = 'True'
		}
        
        Label {
            text: "Panel custom size (Depend on settings above)"
        }
        TextField {
            id: customSize
            placeholderText: qsTr("26px")
            text: i18n(cfg_customSize)
            validator: IntValidator {
                bottom: 1
                top: 9999
            }
        }
	}
    
	ConfigSection {
		label: i18n("Plasma Version")

		RadioButton {
			text: i18nd("kwin_effects", "KDE Plasma v5.13 and above \nAdvanced settings are ignored \nThe panel does not need to be unlocked")
			checked: cfg_newVersion == 'True'
			exclusiveGroup: newVersionGroup
			onClicked: cfg_newVersion = 'True'
		}
		RadioButton {
			text: i18nd("kwin_effects", "KDE Plasma v5.12 and below \nAdvanced settings are used \nThe panel need to be unlocked")
			checked: cfg_newVersion == 'False'
			exclusiveGroup: newVersionGroup
			onClicked: cfg_newVersion = 'False'
		}
	}
    
	ConfigSection {
		label: i18n("Advanced Settings - Unlocking - Affect Plasma Up To v5.12")

		RadioButton {
			text: i18nd("kwin_effects", "Force unlocking the panel \nThe panel may not be relocked (this needs xdotool package)\n(The panel need to be unlocked for this widget to work in plasma < v5.13)")
			checked: cfg_advancedUnlock == 'True'
			exclusiveGroup: advancedUnlockGroup
			onClicked: cfg_advancedUnlock = 'True'
		}
		RadioButton {
			text: i18nd("kwin_effects", "Try classic method to unlock/lock the panel \n(The panel need to be unlocked for this widget to work in plasma < v5.13)")
			checked: cfg_advancedUnlock == 'False'
			exclusiveGroup: advancedUnlockGroup
			onClicked: cfg_advancedUnlock = 'False'
		}
	}    
    
}
