from reportlab.lib.pagesizes import A4
from reportlab.platypus import SimpleDocTemplate, Paragraph, Spacer
from reportlab.lib.styles import getSampleStyleSheet

output = "docs/UART_TX_RTL_to_GDSII_Final_Report.pdf"

doc = SimpleDocTemplate(output, pagesize=A4)
styles = getSampleStyleSheet()
story = []

story.append(Paragraph("UART TX RTL-to-GDSII Project", styles["Title"]))
story.append(Spacer(1, 12))

sections = [
    ("Project", "UART Transmitter RTL-to-GDSII"),
    ("Technology", "Sky130"),
    ("Flow", "OpenLane v1.0.2"),
    ("Design Type", "Sequential / Clocked RTL Design"),
    ("Timing", "WNS: 0.00, TNS: 0.00"),
    ("Worst Setup Slack", "6.63 ns"),
    ("Worst Hold Slack", "0.31 ns"),
    ("Total Power", "5.00e-04 W"),
    ("Internal Power", "3.57e-04 W"),
    ("Switching Power", "1.43e-04 W"),
    ("Leakage Power", "1.64e-09 W"),
    ("DRC", "0 violations"),
    ("LVS", "0 errors"),
    ("XOR", "0 differences"),
    ("Antenna", "0 violations"),
    ("Final GDSII", "Generated successfully"),
]

for title, value in sections:
    story.append(Paragraph(f"<b>{title}:</b> {value}", styles["BodyText"]))
    story.append(Spacer(1, 6))

story.append(Spacer(1, 12))
story.append(Paragraph(
    "The UART transmitter was verified through RTL simulation and "
    "implemented through the complete OpenLane RTL-to-GDSII flow.",
    styles["BodyText"]
))

doc.build(story)
print(f"Report generated: {output}")
