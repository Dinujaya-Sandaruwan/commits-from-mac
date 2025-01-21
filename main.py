from datetime import datetime

# File path
file_path = "data.txt"

# Get the current date and time in the desired format
current_time = datetime.now().strftime("%Y-%m-%d-%H-%M-%S-%f")[:-3]  # Remove the last three digits of microseconds for milliseconds

# Append the date and time to the file
with open(file_path, "a") as file:
    file.write(current_time + "\n")

print(f"Appended current time: {current_time} to {file_path}")
