import numpy as np
import matplotlib.pyplot as plt



# Pie chart, where the slices will be ordered and plotted counter-clockwise:
labels = ['DRL', 'TEB']
sizes = [10,90]

fig, ax = plt.subplots()
ax.pie(sizes, labels=labels, autopct='%1.1f%%', textprops={'fontsize': 20})
ax.axis('equal')  # Equal aspect ratio ensures the pie chart is circular.
#ax.set_title('Outdoor 20 Obs.', fontsize=20)

plt.savefig("pie-simple.png")
