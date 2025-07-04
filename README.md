# RPG Job Selection (CSV Integration in Godot 4.2)

A simple RPG job selection scene built in **Godot 4.2**;how to dynamically load game data from a **CSV file** into a user interface.
- Reads job data (ID, job name, description, and skill list) from `res://resource/classes.csv`
- Displays:
  - A dropdown to select available jobs (Warrior, Mage, Thief)
  - Labels for job name and description
  - A list of job-specific skills
  - A representative character image & class card image per job
 
The data is stored in a semicolon-separated `classes.csv`.
The file is parsed using `FileAccess` and each skill is split at runtime.

You can [download the playable Windows build here](https://codeizra.itch.io/rpg-job-selection-scene)

### Installation Instructions

1. Download the `.zip` file from the [itch.io page](https://codeizra.itch.io/rpg-job-selection-scene)
2. Extract the archive with WinRAR, 7-Zip, or Windows Explorer
3. Open the extracted folder
4. Run `RPGJobSelection.exe`

