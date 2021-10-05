#!/usr/bin/env python
"""
    Example of (almost) all Elements, that you can use in PySimpleGUI.
    Shows you the basics including:
        Naming convention for keys
        Menubar format
        Right click menu format
        Table format
        Running an async event loop
        Theming your application (requires a window restart)
        Displays the values dictionary entry for each element
        And more!
    Copyright 2021 PySimpleGUI
"""

import PySimpleGUI as sg

def make_window(theme):
    sg.theme(theme)
    menu_def = [['&Application', ['E&xit']],
                ['&Help', ['&About']] ]
    right_click_menu_def = [[], ['Nothing','More Nothing','Exit']]

    # Table Data
    data = [["John", 10], ["Jen", 5]]
    headings = ["Name", "Score"]

    default_cfg_layout = [[sg.Menu(menu_def, key='-MENU-')],
                        [sg.Text('Default Config')], 
                        [sg.Checkbox('Checkbox', default=True, k='-CB1-')],
                        [sg.Checkbox('Checkbox', default=True, k='-CB2-')],
                        [sg.Checkbox('Checkbox', default=True, k='-CB3-')],
                        [sg.Checkbox('Checkbox', default=True, k='-CB4-')],
                        [sg.Checkbox('Checkbox', default=True, k='-CB5-')],
                        [sg.Checkbox('Checkbox', default=True, k='-CB6-')],
                        [sg.Checkbox('Checkbox', default=True, k='-CB7-')],
                        [sg.Checkbox('Checkbox', default=True, k='-CB8-')],
                        [sg.Checkbox('Checkbox', default=True, k='-CB9-')]]

    input_layout = [[sg.Input(key='-INPUT-')],
                    [sg.Slider(orientation='h', key='-SKIDER-')],
                    [sg.Checkbox('Checkbox', default=True, k='-CB-')],
                    [sg.Radio('Radio1', "RadioDemo", default=True, size=(10,1), k='-R1-'), sg.Radio('Radio2', "RadioDemo", default=True, size=(10,1), k='-R2-')],
                    [sg.Combo(values=('Combo 1', 'Combo 2', 'Combo 3'), default_value='Combo 1', readonly=True, k='-COMBO-'),
                    sg.OptionMenu(values=('Option 1', 'Option 2', 'Option 3'),  k='-OPTION MENU-'),],
                    [sg.Spin([i for i in range(1,11)], initial_value=10, k='-SPIN-'), sg.Text('Spin')],
                    [sg.Multiline('Demo of a Multi-Line Text Element!\nLine 2\nLine 3\nLine 4\nLine 5\nLine 6\nLine 7\nYou get the point.', size=(45,5), k='-MLINE-')],
                    [sg.Button('Button'), sg.Button('Popup'), sg.Button(image_data=sg.DEFAULT_BASE64_ICON, key='-LOGO-')]]
    
    fig_layout = [[sg.Menu(menu_def, key='-MENU2-')],
                [sg.Text('Default Config')], 
                [sg.Input(key='-INPUT2-')],
                [sg.Checkbox('Checkbox', default=True, k='-CB0-')],
                [sg.Multiline('Demo of a Multi-Line Text Element!\nLine 2\nLine 3\nLine 4\nLine 5\nLine 6\nLine 7\nYou get the point.', size=(45,5), k='-MLINE2-')]]

    layout = [[sg.Text('Evaluation', size=(38, 1), justification='center', font=("Helvetica", 16), relief=sg.RELIEF_RIDGE, k='-TEXT HEADING-', enable_events=True)]]
    layout +=[[sg.TabGroup([[  sg.Tab('Default config', default_cfg_layout)]], key='-TAB GROUP def-')]]
    layout +=[[sg.TabGroup([[  sg.Tab('Input Elements', input_layout)]], key='-TAB GROUP fig1-')]]
    layout +=[[sg.TabGroup([[  sg.Tab('Figure 2', fig_layout)]], key='-TAB GROUP fig2-')]]
              
    return sg.Window('All Elements Demo', layout, right_click_menu=right_click_menu_def)


def main():
    window = make_window(sg.theme())
    
    # This is an Event Loop 
    while True:
        event, values = window.read(timeout=100)
        # keep an animation running so show things are happening
        if event not in (sg.TIMEOUT_EVENT, sg.WIN_CLOSED):
            print('============ Event = ', event, ' ==============')
            print('-------- Values Dictionary (key=value) --------')
            for key in values:
                print(key, ' = ',values[key])
        if event in (None, 'Exit'):
            print("[LOG] Clicked Exit!")
            break
        elif event == 'About':
            print("[LOG] Clicked About!")
            sg.popup('PySimpleGUI Demo All Elements',
                     'Right click anywhere to see right click menu',
                     'Visit each of the tabs to see available elements',
                     'Output of event and values can be see in Output tab',
                     'The event and values dictionary is printed after every event')
        elif event == 'Popup':
            print("[LOG] Clicked Popup Button!")
            sg.popup("You pressed a button!")
            print("[LOG] Dismissing Popup!")
        elif event == 'Test Progress bar':
            print("[LOG] Clicked Test Progress Bar!")
            progress_bar = window['-PROGRESS BAR-']
            for i in range(1000):
                print("[LOG] Updating progress bar by 1 step ("+str(i)+")")
                progress_bar.UpdateBar(i + 1)
            print("[LOG] Progress bar complete!")
        elif event == "-GRAPH-":
            graph = window['-GRAPH-']       # type: sg.Graph
            graph.draw_circle(values['-GRAPH-'], fill_color='yellow', radius=20)
            print("[LOG] Circle drawn at: " + str(values['-GRAPH-']))
        elif event == "Open Folder":
            print("[LOG] Clicked Open Folder!")
            folder_or_file = sg.popup_get_folder('Choose your folder')
            sg.popup("You chose: " + str(folder_or_file))
            print("[LOG] User chose folder: " + str(folder_or_file))
        elif event == "Open File":
            print("[LOG] Clicked Open File!")
            folder_or_file = sg.popup_get_file('Choose your file')
            sg.popup("You chose: " + str(folder_or_file))
            print("[LOG] User chose file: " + str(folder_or_file))
        elif event == "Set Theme":
            print("[LOG] Clicked Set Theme!")
            theme_chosen = values['-THEME LISTBOX-'][0]
            print("[LOG] User Chose Theme: " + str(theme_chosen))
            window.close()
            window = make_window(theme_chosen)

    window.close()
    exit(0)

if __name__ == '__main__':
    main()