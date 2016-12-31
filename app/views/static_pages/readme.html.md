#User manual

The Kribi Operations App is a system to log Operations readings and events data. The data can then be used to generate reports or perform data and trends analysis for purposes such as trip analysis, LFO consumption analysis, efficiency, Etc. The data is kept in a database. This database contains all data that has been input ever.

To enter the system, you need to have a user name and a password. Once you enter the system, and depending on your function and hierarchy, you may have different roles, which may include:

- **Data input:** this is the most common role. The people with this role is able to enter the system and input data.
- **Reviewer:** Reviews that data makes sense, so only good data is saved.
- **Approver:** Approver is the final filter. Once data is approved, it shouldn't be changed.
 
![public home](/readme/user_manual_intro_01public_home.png "test")

Once you finish using the system, it is important that you logout, so other person cannot inadvertently use the system with your credentials. Logout link is on the top right area of the application.

Once you are properly logged in, you will be presented with the following screen:

![private home overview](/readme/user_manual_intro_02private_home.png "test2")

The above image is the main navigation screen. To the left there is the main menu, and in the center stage there are charts and some shortcuts.

The system is composed of three main sections, which are described below:

- **Readings.** This section contains several resources for data input, which capture snapshots of the Operation. This means that 5 minute data, hourly data, and daily data is input here. Resources include Chromatograph data, energy readings, transformer readings, etc. 
- **Events.** Any event related to the operation is recorded here. An event is not an hourly input, but an ocurrence input. So date and time of the events, along with description of events are input here. Resources for event input include the Operations events, the engine status, oil charge, Etc.
- **Downloads.** The downloads section allows to get data from the database for reporting or analysis purposes. You can download either all resources with one click, or any one particular resource (events or readings).

The following sections explain how to use the system.

---


##Readings

Includes recording readings for: Transformer, chromatograph, engine LFO, Engine cummulative running hours, engine emissions, engine energy, engine gas (GRU), gas contractual, GPRS, MV outgoing feeder, plant common LFO, plant declared capacity, plant gross capacity, plant reference conditions, substation consumption, and weather.

For any of the batch resources, when you click on the designated link, you will be presented with a table of input cells. The input cells will be for a specific date, which is the one exactly after the latest one approved (the very first row, is the most recent approved record from previous day). The date for input is shown on top of the web page. You can only input data when there is already data for the previous day. Each row represents a specific time of the day, while each column title represents the type of data expected to be input. See the diagram below:

![Readings input overview](/readme/user_manual_readings_01overview.png "Readings overview - example of data input")

To navigate through the input table, you can use the mouse, or the keyboard. When using the keyboard, click the 'tab' key to go to the next right cell; click 'enter' to go next below cell. 

When completing all inputs for that page, you need to click the 'update' button (see next image). When you click the 'update' button, the app internally checks if values are valid according to the validation rules. If there are any values not meeting the validation rules, the cells will be outlined with red color. After you review and correct the cells, click 'update' again. If data is valid, you will receive a 'success' green message on top of the page indicating that the data has been saved in 'pending' state. For the data to be available for reports and to be able to input the next day, the data needs to be 'approved'. So, after confirming that data is OK, need to request a person with approval rights, to 'approve' the day's information.

![Readings input overview success](/readme/user_manual_readings_02success.png "Readings overview - success")

For some of the Readings resources, things happen to equipment counters. So resets need to be considered. Since for many of the resources the counter values are relative to when counter was initialized, if a reset happens accidentally or if the counter reached its maximum permissible value, you need to perform a special input. The application allows you to add a value to compensate for the reading value. See next images for explanation:

![Reset correction method](/readme/user_manual_readings_03reset_counter_value.png "Reset correction method")

So, once you click on the 'Show reset/offset options' checkbox, one more value input cell will appear. In this new cell you can input the counter offset. The 'counter offset' is the last value available when the reset happened.

##Events

Includes resources to record events that have an effect on the operation. Event resources include  Engine status change events, engine operation events, grid demand instruction events, oil and cooling water events as well.

For events links, after clicking one of the links,  a row will appear to input details of the event. For engines, you have to select the number of the engine before inputing the details of the event.

![Event input overview](/readme/user_manual_events_01overview.png "Event input overview")

Once the event details are recorded, click on the 'create' button. If data is valid and there are no validation issues, the event will be saved in 'PENDING' status. In order to have the data available for reporting, the event data needs to be approved. The events will appear below. You may approve each particular event record, or opt for selecting several event records to update to same state, at the same time. To approve one event record, go to that listed event, on the right side, change the state from 'pending', or 'reviewed' to 'approved', and then click 'change status'. To approve several events at the same time, click on the left side checkboxes of the events you want to change state to. Then, on the 'collection actions' section below the list of events, select the new state from the dropdown menu, such as 'approved', and then click the 'change status' button.

![Event approvals](/readme/user_manual_events_02approval.png "Event record approval")

##Downloads

All data that has been input to the database system is available to be downloaded. The data can be downloaded in a file type that can be opened in Excel. Once in Excel, it can be used for reports or analysis.

The available options for download are:

####Main downloads

- **all dumps**. It is a zip file including data of all resources, such as readings and events. Just click the 'download' button and the zip file will be available.
- **Aggregates**. Includes one file that is used as input for reporting purposes. Click the 'download' button.

####Dumps of Readings and Events

Dumps of readings and events can be downloaded individually. The date column indicates the last approved date for each particular resource.


#Get help

In case there are further questions, please send email to <adiaz@abante.com.mx> or channel your questions through the project leader (Etienne). With your feedback we can improve the system and its documentation.

#User management

Currently user management is done directly by the app developers. In case there is need to add users, or change roles, please request developers. Contact <adiaz@abante.com.mx>.