#!/bin/bash

# This script can automate file and folder management tasks such as copying, moving, deleting, renaming, creating backups, and compressing files into archives. Use at your own risk!

# Default directory
default_dir=~/Desktop

# Function to copy files
copy_files() {
    read -p "Enter the source file or folder path: " source_path
    read -p "Enter the destination folder path [$default_dir]: " destination_path
    destination_path=${destination_path:-$default_dir}

    echo "Are you sure you want to copy $source_path to $destination_path? (y/n)"
    read answer
    if [[ "$answer" == "y" || "$answer" == "Y" ]]; then
        cp -r $source_path $destination_path
        echo "Files copied successfully!"
    else
        echo "Copy operation cancelled by user."
    fi
}

# Function to move files
move_files() {
    read -p "Enter the source file or folder path: " source_path
    read -p "Enter the destination folder path [$default_dir]: " destination_path
    destination_path=${destination_path:-$default_dir}

    echo "Are you sure you want to move $source_path to $destination_path? (y/n)"
    read answer
    if [[ "$answer" == "y" || "$answer" == "Y" ]]; then
        mv $source_path $destination_path
        echo "Files moved successfully!"
    else
        echo "Move operation cancelled by user."
    fi
}

# Function to delete files
delete_files() {
    read -p "Enter the file or folder path you want to delete: " file_path
    read -p "Enter the folder path where the file/folder is located [$default_dir]: " dir_path
    dir_path=${dir_path:-$default_dir}

    echo "WARNING: This action cannot be undone. Type DELETE to continue."
    read confirmation
    if [[ "$confirmation" == "DELETE" || "$confirmation" == "delete" ]]; then
        echo "Are you sure you want to delete $file_path from $dir_path? (y/n)"
        read answer
        if [[ "$answer" == "y" || "$answer" == "Y" ]]; then
            rm -rf $dir_path/$file_path
            echo "Files deleted successfully!"
        else
            echo "Delete operation cancelled by user."
        fi
    else
        echo "Delete operation cancelled by user."
    fi
}

# Function to rename files
rename_files() {
    read -p "Enter the file or folder path you want to rename: " file_path
    read -p "Enter the new name for the file or folder: " new_name
    read -p "Enter the folder path where the file/folder is located [$default_dir]: " dir_path
    dir_path=${dir_path:-$default_dir}

    echo "Are you sure you want to rename $file_path to $new_name in $dir_path? (y/n)"
    read answer
    if [[ "$answer" == "y" || "$answer" == "Y" ]]; then
        mv $dir_path/$file_path $dir_path/$new_name
        echo "Files renamed successfully!"
    else
        echo "Rename operation cancelled by user."
    fi
}

# Function to create backups
create_backup() {
    read -p "Enter the file or folder path you want to backup: " file_path
    read -p "Enter the name for the backup: " backup_name
    read -p "Enter the backup folder path [$default_dir]: " backup_path
    backup_path=${backup_path:-$default_dir}

    echo "Are you sure you want to create a backup of $file_path with the name $backup_name in $backup_path? (y/n)"
    read answer
    if [[ "$answer" == "y" || "$answer" == "Y" ]]; then
        cp -r $file_path $backup_path/$backup_name
        echo "Backup created successfully!"
    else
        echo "Backup operation cancelled by user."
    fi
}

# Function to compress files
compress_files() {
    read -p "Enter the file or folder path you want to compress: " file_path

    echo "Are you sure you want to compress $file_path? (y/n)"
    read answer
    if [[ "$answer" == "y" || "$answer" == "Y" ]]; then
        tar -czvf $file_path.tar.gz $file_path
        echo "Files compressed successfully!"
    else
        echo "Compression operation cancelled by user."
    fi
}

# Menu to select the task
echo "Welcome to the File and Folder Management script!"
echo "Please select a task from the following options:"

PS3='Please enter your choice: '
options=("Copy files" "Move files" "Delete files" "Rename files" "Create backup" "Compress files" "Quit")
select opt in "${options[@]}"
do
    case $opt in
        "Copy files")
            copy_files
            ;;
        "Move files")
            move_files
            ;;
        "Delete files")
            delete_files
            ;;
        "Rename files")
            rename_files
            ;;
        "Create backup")
            create_backup
            ;;
        "Compress files")
            compress_files
            ;;
        "Quit")
            break
            ;;
        *) echo "Invalid option $REPLY";;
    esac
done

echo "Thank you for using the File and Folder Management script!"
