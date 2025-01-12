# DSWRP
DirectSound Wrapper Registry Patcher  
By 3DJ with credit to Henky!!, John-Paul Ownby and Nucleoprotein  
Originally posted in https://github.com/kcat/dsoal/issues/34#issuecomment-1139239755  
Automated and expanded version of:
  - https://www.indirectsound.com/registryIssues.html
  - https://www.vogons.org/viewtopic.php?p=692601#p692601  

This registry key patch script is required for some apps/games to load the local `dsound.dll` (used by DirectSound3D wrappers like DSOAL and Creative ALchemy) instead of `C:\Windows\SysWOW64\dsound.dll` on Windows 8+ 64-bit.  

It also creates a `Backup.reg` file that you can merge to revert all changes made by the script.
The release version includes SetACL ([with explicit permission from the developer as required](https://github.com/user-attachments/assets/f7801af2-93d3-4ec6-8b59-d746cd6c5328)), a program that automatically takes ownerwhip of the system-protected registry keys so that the user doesn't have to.

# Instructions


- Right-click `DirectSound Wrapper Registry Patcher.cmd` script file > **Run as an administrator** (needed for SetACL)
- You should see a list of patched registry keys in green text, indicating it succeeded:
![image](https://github.com/user-attachments/assets/72ae2569-3f1b-4405-9764-55487fc89a1a)
- App/games should now be able to load dsound.dll replacements like DSOAL/ALchemy.
