# This imports all the layers for "DropTicket_ticket_nfc" into dropticket_ticket_nfcLayers
layers = Framer.Importer.load "imported/DropTicket_ticket_nfc"

Framer.Device.contentScale = 1.5

materialCurveMove = "cubic-bezier(0.4, 0, 0.2, 1)"
materialCurveEnter = "cubic-bezier(0, 0, 0.2, 1)"
materialCurveExit = "cubic-bezier(0.4, 0, 1, 1)"

Framer.Defaults.Animation =
	curve: materialCurveMove
	time: 1

smartphone = layers["smartphone"]
smartphone.states.add
	right: {x: 460,rotation: 15}
	left: {x: 300, rotation: -15}
	
nfc = layers["nfc"]
icon = layers["dropticket_icon"]
	
smartphone.states.switchInstant "right"
smartphone.states.switch "left"
Utils.interval 2, ->
	smartphone.states.next "left", "right"

smartphone.on Events.StateDidSwitch, (prev, curr) ->
	if prev is "right" and curr is "left"
		growAnim = nfc.animate
			properties:
				scale: 1.2
			time: 0.4
		growAnim2 = icon.animate
			properties:
				scale: 1.2
			time: 0.4
			delay: 0.4
		growAnim.on Events.AnimationEnd, ->
			nfc.animate
				properties:
					scale: 1
				time: 0.4
		growAnim2.on Events.AnimationEnd, ->
			icon.animate
				properties:
					scale: 1
				time: 0.4
		