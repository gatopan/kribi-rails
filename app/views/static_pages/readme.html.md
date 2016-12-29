
![alt text](/readme/ticktick.gif "tick tick")


User manual
==

The Kribi Operations App is an system to log Operations readings and events data. The data can then be used to generate reports or perform data and trends analysis for purposes such as trip analysis, LFO consumption analysis, efficiency, Etc. The data is kept in a database. This database contains all data that has been input ever.

To enter the system, you need to have a user name and a password. Once you enter the system, and depending on your function and hierarchy, you may have different roles, which may include:

- **Data input:** this is the most common role. The people with this role is able to enter the system and input data.
- **Reviewer:** Reviews that data makes sense, so only good data is saved.
- **Approver:** Approver is the final filter. Once data is approved, it shouldn't be changed.
 
Once you finish using the system, it is important that you logout, so other person cannot inadvertently use the system with your credentials. Logout link is on the top right area of the application.

The system is composed of three main sections, which are described below:

- **Readings.** This section contains several resources for data input, which capture snapshots of the Operation. This means that 5 minute data, hourly data, and daily data is input here. Resources include Chromatograph data, energy readings, transformer readings, etc. 
- **Events.** Any event related to the operation is recorded here. An event is not an hourly input, but an ocurrence input. So date and time of the events, along with description of events are input here. Resources for event input include the Operations events, the engine status, oil charge, Etc.
- **Export.** The export section allows to download data from the database for reporting or analysis purposes. You can download either all resources with one click, or any one particular resource (events or batches).

The following sections explain in detail how to use the system.

---


Readings
--

Includes recording readings for: Transformer, chromatograph, engine LFO, Engine cummulative running hours, engine emissions, engine energy, engine gas (GRU), gas contractual, GPRS, MV outgoing feeder, plant common LFO, plant declared capacity, plant gross capacity, plant reference conditions, substation consumption, and weather.

For any of the batch resources, when you click on the designated link, you will be presented with a table of input cells. The input cells will be for a specific date, which is the one exactly after the latest one approved. The date for input is prominently shown on top of the web page. You can only input data when there is already data for the previous day. Each row represents a specific time of the day, while each column title represents the type of data expected to be input. See the diagram below:


To navigate through the input table, you can use the mouse, or the keyboard. When using the keyboard, click the 'tab' key to go to the next right cell; click 'enter' to go next below cell. 

When completing all inputs for that page, you need to click the 'update' button. When you click the 'update' button, the app internally checks if values are valid according to the validation rules. If there is any value not meeting the validation rules, the cell(s) will be red-outlined. After you review and correct the cells, click 'update' again. If data is valid, you will receive a 'success' green message on top of the page.


Events
--

Export
--

Get help
--

Admin manual
==

User management
--

Get help
--