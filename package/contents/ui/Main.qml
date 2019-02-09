import QtQuick 2.0
import QtQuick.Layouts 1.1
import org.kde.plasma.plasmoid 2.0
import org.kde.plasma.core 2.0 as PlasmaCore

import "lib"

Item {
	id: widget

	property bool disableLatteParabolicIcon: true // Don't hide the representation in Latte (https://github.com/psifidotos/Latte-Dock/issues/983)
    
    property var plasmascript: ''
    property var plasmascriptline1: ''
    property var plasmascriptline2: ''
    property var plasmascriptline3: ''
    property var plasmascriptline4: ''
    property var plasmascriptline5: ''
    property var plasmascriptline6: ''
    property var script: "setImmutability('mutable');"
    property var unlockHacky1: 'qdbus org.kde.kglobalaccel /component/plasmashell invokeShortcut "show dashboard"; '
    property var unlockHacky2: 'xdotool key alt+d l; qdbus org.kde.kglobalaccel /component/plasmashell invokeShortcut "show dashboard"'
    property var advancedScript_p1: 'qdbus org.kde.plasmashell /PlasmaShell org.kde.PlasmaShell.evaluateScript '
    property var advancedScript_p2: "setImmutability('userImmutable');"
    property var workingMode: 'if (panel.height > 0) {panel.height = panel.height * -1;}"'
    property var manualHide: 'False'
    property var manualShow: 'False'

	Plasmoid.onActivated: widget.activate()
    
	Plasmoid.preferredRepresentation: Plasmoid.fullRepresentation
	Plasmoid.fullRepresentation: Item {
		id: panelItem

		readonly property bool inPanel: (plasmoid.location == PlasmaCore.Types.TopEdge
			|| plasmoid.location == PlasmaCore.Types.RightEdge
			|| plasmoid.location == PlasmaCore.Types.BottomEdge
			|| plasmoid.location == PlasmaCore.Types.LeftEdge)

		Layout.minimumWidth: {
			switch (plasmoid.formFactor) {
			case PlasmaCore.Types.Vertical:
				return 0;
			case PlasmaCore.Types.Horizontal:
				return height;
			default:
				return units.gridUnit * 3;
			}
		}

		Layout.minimumHeight: {
			switch (plasmoid.formFactor) {
			case PlasmaCore.Types.Vertical:
				return width;
			case PlasmaCore.Types.Horizontal:
				return 0;
			default:
				return units.gridUnit * 3;
			}
		}

		Layout.maximumWidth: inPanel ? units.iconSizeHints.panel : -1
		Layout.maximumHeight: inPanel ? units.iconSizeHints.panel : -1

		AppletIcon {
			id: icon
			anchors.fill: parent

			source: plasmoid.configuration.icon
			active: mouseArea.containsMouse
		}

		MouseArea {
			id: mouseArea
			anchors.fill: parent
			hoverEnabled: true
			onClicked: widget.activate()
		}
	}
    
	PlasmaCore.DataSource {
		id: executable
		engine: "executable"
		connectedSources: []
		onNewData: disconnectSource(sourceName)

		function exec(cmd) {
			executable.connectSource(cmd)
		}
	}
    
	function action_prepareScript() {        
    
        if (plasmoid.configuration.forceSize == 'True') {
        
            plasmascriptline2 = "if (panel.height == 0) {panel.height = " + plasmoid.configuration.customSize + "} else {panel.height = 0;} ";
            workingMode = 'if (panel.height > 0) {panel.height = 0;}"' //Used for auto hide feature
            
            if (manualHide == 'True') {
                plasmascriptline2 = "if (panel.height > 0) {panel.height = 0;} ";
            }
            
            if (manualShow == 'True') {
                plasmascriptline2 = "if (panel.height == 0) {panel.height = " + plasmoid.configuration.customSize + "} ";
            }
            
        } else {
        
            plasmascriptline2 = "panel.height = panel.height * -1; ";
            workingMode = 'if (panel.height > 0) {panel.height = panel.height * -1;}"' //Used for auto hide feature
            
            if (manualHide == 'True') {
                plasmascriptline2 = "if (panel.height > 0) {panel.height = panel.height * -1;} ";
            }
            if (manualShow == 'True') {
                plasmascriptline2 = "if (panel.height < 0) {panel.height = panel.height * -1;} ";
            }
            
        }
        

        
        if (plasmoid.configuration.forceDis == 'True') {
            plasmascriptline3 = "if (panel.location == 'left') {panel.location = 'right'; sleep(5); panel.location = 'left';} ";
            plasmascriptline4 = "if (panel.location == 'top') {panel.location = 'bottum'; sleep(5); panel.location = 'top';} ";
            plasmascriptline5 = "if (panel.location == 'right') {panel.location = 'left'; sleep(5); panel.location = 'right';} ";
            plasmascriptline6 = "if (panel.location == 'bottum') {panel.location = 'top'; sleep(5); panel.location = 'bottum'; }";
        } else {
            plasmascriptline3 = "";
            plasmascriptline4 = "";
            plasmascriptline5 = "";
            plasmascriptline6 = "";
        }
        
        if (plasmoid.configuration.clickCommandID == 'PanelID0') {
            plasmascriptline1 = "panel = panelById(panelIds[0]); ";
        }
        if (plasmoid.configuration.clickCommandID == 'PanelID1') {
            plasmascriptline1 = "panel = panelById(panelIds[1]); ";
        }
        if (plasmoid.configuration.clickCommandID == 'PanelID2') {
            plasmascriptline1 = "panel = panelById(panelIds[2]); ";
        }
        if (plasmoid.configuration.clickCommandID == 'PanelID3') {
            plasmascriptline1 = "panel = panelById(panelIds[3]); ";
        }
        if (plasmoid.configuration.clickCommandID == 'PanelID4') {
            plasmascriptline1 = "panel = panelById(panelIds[4]); ";
        }
        if (plasmoid.configuration.clickCommandID == 'PanelID5') {
            plasmascriptline1 = "panel = panelById(panelIds[5]); ";
        }
        if (plasmoid.configuration.clickCommandID == 'PanelID6') {
            plasmascriptline1 = "panel = panelById(panelIds[6]); ";
        }
    
        plasmascript = plasmascriptline1 + plasmascriptline2 + plasmascriptline3 + plasmascriptline4 + plasmascriptline5 + plasmascriptline6;
	}
    
    function action_lockPanelCode() {
        executable.exec("qdbus org.kde.plasmashell /PlasmaShell org.kde.PlasmaShell.evaluateScript 'locked = true;'");
        executable.exec(advancedScript_p1 + '"' + advancedScript_p2 + '"');
	}
    
    Timer {
        id:timerLockPanel
        interval: 800
        onTriggered: action_lockPanelCode()
    }
    
    Timer {
        id:timerLockPanelLong
        interval: 12000
        onTriggered: action_lockPanelCode()
    }
    
    Timer {
        id:timerDelayToggle
        interval: 800
        onTriggered: executable.exec('qdbus org.kde.plasmashell /PlasmaShell evaluateScript ' + '"' + plasmascript + '"');
    }
    
    Timer {
        id:timerDelayToggleDisalbe0
        interval: 800
        onTriggered: executable.exec('qdbus org.kde.plasmashell /PlasmaShell evaluateScript "panel = panelById(panelIds[0]); ' + workingMode);
    }
    
    Timer {
        id:timerDelayToggleDisalbe1
        interval: 800
        onTriggered: executable.exec('qdbus org.kde.plasmashell /PlasmaShell evaluateScript "panel = panelById(panelIds[1]); ' + workingMode);
    }
    
    Timer {
        id:timerDelayToggleDisalbe2
        interval: 800
        onTriggered: executable.exec('qdbus org.kde.plasmashell /PlasmaShell evaluateScript "panel = panelById(panelIds[2]); ' + workingMode);
    }
    
    Timer {
        id:timerDelayToggleDisalbe3
        interval: 800
        onTriggered: executable.exec('qdbus org.kde.plasmashell /PlasmaShell evaluateScript "panel = panelById(panelIds[3]); ' + workingMode);
    }
    
    Timer {
        id:timerDelayToggleDisalbe4
        interval: 800
        onTriggered: executable.exec('qdbus org.kde.plasmashell /PlasmaShell evaluateScript "panel = panelById(panelIds[4]); ' + workingMode);
    }
    
    Timer {
        id:timerDelayToggleDisalbe5
        interval: 800
        onTriggered: executable.exec('qdbus org.kde.plasmashell /PlasmaShell evaluateScript "panel = panelById(panelIds[5]); ' + workingMode);
    }
    
    Timer {
        id:timerDelayToggleDisalbe6
        interval: 800
        onTriggered: executable.exec('qdbus org.kde.plasmashell /PlasmaShell evaluateScript "panel = panelById(panelIds[6]); ' + workingMode);
    }
    
	function action_unlockPanel() {
        executable.exec('qdbus org.kde.plasmashell /PlasmaShell evaluateScript ' + '"' + script + '"');
        
        if (plasmoid.configuration.advancedUnlock == 'True') {
            //If Plasma < v5.13 Then Use The Hacky Method
            if (plasmoid.immutability !== PlasmaCore.Types.Mutable) {
                executable.exec(unlockHacky1 + unlockHacky2);
            }
        } else {
            if (plasmoid.immutability !== PlasmaCore.Types.Mutable) {
                executable.exec("notify-send 'Toggle-Panel-Button :' 'Unable to unlock panel... \nPanel need to be unlocked...'");
            }
        }
	}
    
	function action_lockPanel() {
        if (plasmoid.configuration.advancedUnlock == 'True') {
            timerLockPanelLong.start();
        } else {
            timerLockPanel.start();
        }
        //executable.exec("qdbus org.kde.plasmashell /PlasmaShell org.kde.PlasmaShell.evaluateScript 'locked = true;'");
        //qdbus org.kde.plasmashell /PlasmaShell org.kde.PlasmaShell.evaluateScript "setImmutability('userImmutable');"
	}
        
	function action_showDesktopGrid() {
		executable.exec('qdbus org.kde.kglobalaccel /component/kwin invokeShortcut "ShowDesktopGrid"')
	}
    
    function action_PanelTimerCode0() {
        if ((plasmoid.immutability !== PlasmaCore.Types.Mutable) && (plasmoid.configuration.newVersion == 'False')) {
            //Not-Unlocked
            action_unlockPanel();
            if (plasmoid.configuration.advancedUnlock == 'True') {
                timerDelayToggleDisalbe0.start();
            } else {
                executable.exec('qdbus org.kde.plasmashell /PlasmaShell evaluateScript "panel = panelById(panelIds[0]); ' + workingMode);
            }
            action_lockPanel();
        } else {
            executable.exec('qdbus org.kde.plasmashell /PlasmaShell evaluateScript "panel = panelById(panelIds[0]); ' + workingMode)
        }
    }
    
    function action_PanelTimerCode1() {
        if ((plasmoid.immutability !== PlasmaCore.Types.Mutable) && (plasmoid.configuration.newVersion == 'False')) {
            //not unlocked
            action_unlockPanel();
            if (plasmoid.configuration.advancedUnlock == 'True') {
                timerDelayToggleDisalbe1.start();
            } else {
                executable.exec('qdbus org.kde.plasmashell /PlasmaShell evaluateScript "panel = panelById(panelIds[1]); ' + workingMode);
            }
            action_lockPanel();
        } else {
            executable.exec('qdbus org.kde.plasmashell /PlasmaShell evaluateScript "panel = panelById(panelIds[1]); ' + workingMode)
        }
    }
    
    function action_PanelTimerCode2() {
        if ((plasmoid.immutability !== PlasmaCore.Types.Mutable) && (plasmoid.configuration.newVersion == 'False')) {
            //not unlocked
            action_unlockPanel();
            if (plasmoid.configuration.advancedUnlock == 'True') {
                timerDelayToggleDisalbe2.start();
            } else {
                executable.exec('qdbus org.kde.plasmashell /PlasmaShell evaluateScript "panel = panelById(panelIds[2]); ' + workingMode);
            }
            action_lockPanel();
        } else {
            executable.exec('qdbus org.kde.plasmashell /PlasmaShell evaluateScript "panel = panelById(panelIds[2]); ' + workingMode)
        }
    }
    
    function action_PanelTimerCode3() {
        if ((plasmoid.immutability !== PlasmaCore.Types.Mutable) && (plasmoid.configuration.newVersion == 'False')) {
            //not unlocked
            action_unlockPanel();
            if (plasmoid.configuration.advancedUnlock == 'True') {
                timerDelayToggleDisalbe3.start();
            } else {
                executable.exec('qdbus org.kde.plasmashell /PlasmaShell evaluateScript "panel = panelById(panelIds[3]); ' + workingMode);
            }
            action_lockPanel();
        } else {
            executable.exec('qdbus org.kde.plasmashell /PlasmaShell evaluateScript "panel = panelById(panelIds[3]); ' + workingMode)
        }
    }
    
    function action_PanelTimerCode4() {
        if ((plasmoid.immutability !== PlasmaCore.Types.Mutable) && (plasmoid.configuration.newVersion == 'False')) {
            //not unlocked
            action_unlockPanel();
            if (plasmoid.configuration.advancedUnlock == 'True') {
                timerDelayToggleDisalbe4.start();
            } else {
                executable.exec('qdbus org.kde.plasmashell /PlasmaShell evaluateScript "panel = panelById(panelIds[4]); ' + workingMode);
            }
            action_lockPanel();
        } else {
            executable.exec('qdbus org.kde.plasmashell /PlasmaShell evaluateScript "panel = panelById(panelIds[4]); ' + workingMode)
        }
    }
    
    function action_PanelTimerCode5() {
        if ((plasmoid.immutability !== PlasmaCore.Types.Mutable) && (plasmoid.configuration.newVersion == 'False')) {
            //not unlocked
            action_unlockPanel();
            if (plasmoid.configuration.advancedUnlock == 'True') {
                timerDelayToggleDisalbe5.start();
            } else {
                executable.exec('qdbus org.kde.plasmashell /PlasmaShell evaluateScript "panel = panelById(panelIds[5]); ' + workingMode);
            }
            action_lockPanel();
        } else {
            executable.exec('qdbus org.kde.plasmashell /PlasmaShell evaluateScript "panel = panelById(panelIds[5]); ' + workingMode)
        }
    }
    
    function action_PanelTimerCode6() {
        if ((plasmoid.immutability !== PlasmaCore.Types.Mutable) && (plasmoid.configuration.newVersion == 'False')) {
            //not unlocked
            action_unlockPanel();
            if (plasmoid.configuration.advancedUnlock == 'True') {
                timerDelayToggleDisalbe6.start();
            } else {
                executable.exec('qdbus org.kde.plasmashell /PlasmaShell evaluateScript "panel = panelById(panelIds[6]); ' + workingMode);
            }
            action_lockPanel();
        } else {
            executable.exec('qdbus org.kde.plasmashell /PlasmaShell evaluateScript "panel = panelById(panelIds[6]); ' + workingMode)
        }
    }

    Timer {
        id:timerToggle0
        interval: 10000
        onTriggered: action_PanelTimerCode0()
    }

    Timer {
        id:timerToggle1
        interval: 10000
        onTriggered: action_PanelTimerCode1()
    }

    Timer {
        id:timerToggle2
        interval: 10000
        onTriggered: action_PanelTimerCode2()
    }

    Timer {
        id:timerToggle3
        interval: 10000
        onTriggered: action_PanelTimerCode3()
    }

    Timer {
        id:timerToggle4
        interval: 10000
        onTriggered: action_PanelTimerCode4()
    }

    Timer {
        id:timerToggle5
        interval: 10000
        onTriggered: action_PanelTimerCode5()
    }

    Timer {
        id:timerToggle6
        interval: 10000
        onTriggered: action_PanelTimerCode6()
    }
    
	function action_HideUnhide() {
    
        action_prepareScript();
        
        if (plasmoid.configuration.newVersion == 'True') {
            executable.exec('qdbus org.kde.plasmashell /PlasmaShell evaluateScript ' + '"' + plasmascript + '"');
        } else {
            if (plasmoid.immutability !== PlasmaCore.Types.Mutable) {
                //not unlocked
                action_unlockPanel();
                if (plasmoid.configuration.advancedUnlock == 'True') {
                    timerDelayToggle.start();
                } else {
                    executable.exec('qdbus org.kde.plasmashell /PlasmaShell evaluateScript ' + '"' + plasmascript + '"');
                }
                action_lockPanel();
            } else {
                executable.exec('qdbus org.kde.plasmashell /PlasmaShell evaluateScript ' + '"' + plasmascript + '"');
            }
        }
        
	}
    
	function activate() {        
		if (plasmoid.configuration.clickCommand == 'HideAutoUnhide') {
            if (plasmoid.configuration.clickCommandID == 'PanelID0') {action_HideUnhide();timerToggle0.start();}
            if (plasmoid.configuration.clickCommandID == 'PanelID1') {action_HideUnhide();timerToggle1.start();}
            if (plasmoid.configuration.clickCommandID == 'PanelID2') {action_HideUnhide();timerToggle2.start();}
            if (plasmoid.configuration.clickCommandID == 'PanelID3') {action_HideUnhide();timerToggle3.start();}
            if (plasmoid.configuration.clickCommandID == 'PanelID4') {action_HideUnhide();timerToggle4.start();}
            if (plasmoid.configuration.clickCommandID == 'PanelID5') {action_HideUnhide();timerToggle5.start();}
            if (plasmoid.configuration.clickCommandID == 'PanelID6') {action_HideUnhide();timerToggle6.start();}
		} 
        else if (plasmoid.configuration.clickCommand == 'HideUnhide') {
            action_HideUnhide()
		}
	}    
    
	function action_hideDesktopPanel() {
        manualHide = 'True';
        action_HideUnhide();
        manualHide = 'False';
	}  
    
	function action_showDesktopPanel() {
        manualShow = 'True';
        action_HideUnhide();
        manualShow = 'False';
	}  

	Component.onCompleted: {
		plasmoid.setAction("showDesktopGrid", i18n("Show Desktop Grid"), "view-grid");
        plasmoid.setAction("hideDesktopPanel", i18n("Hide Panel"), "bboxnext");
        plasmoid.setAction("showDesktopPanel", i18n("Show Panel"), "bboxprev");
		//plasmoid.action('configure').trigger() // Uncomment to open the config window on load.
	}
}
