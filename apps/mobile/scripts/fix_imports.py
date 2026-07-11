import os

directory = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
target_str = "package:life_circle_os/"
replacement_str = "package:lifecircle_mobile/"

count = 0
files_modified = 0

for root, _, files in os.walk(directory):
    for file in files:
        if file.endswith(".dart"):
            filepath = os.path.join(root, file)
            with open(filepath, "r", encoding="utf-8") as f:
                content = f.read()
            
            if target_str in content:
                new_content = content.replace(target_str, replacement_str)
                with open(filepath, "w", encoding="utf-8") as f:
                    f.write(new_content)
                files_modified += 1
                count += content.count(target_str)

print(f"✅ Replaced {count} occurrences of {target_str} in {files_modified} files.")
