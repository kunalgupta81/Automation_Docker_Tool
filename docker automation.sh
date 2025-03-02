#!/bin/bash

while true; do
    echo -e "\nDocker Management Script"
    echo "--------------------------------"
    echo "1.  List Docker Images"
    echo "2.  Install an OS Image"
    echo "3.  Pull Ubuntu 14.04"
    echo "4.  List Running Containers"
    echo "5.  Start a Container"
    echo "6.  Stop a Container"
    echo "7.  Remove a Container"
    echo "8.  Remove an Image"
    echo "9.  View Container Logs"
    echo "10. View Real-Time Container Stats"
    echo "11. Build Docker Image from Dockerfile"
    echo "12. Save Docker Image to Tar File"
    echo "13. Load Docker Image from Tar File"
    echo "14. Manage Docker Networks"
    echo "15. Manage Docker Volumes"
    echo "16. Pull Popular Docker Images"
    echo "17. Install Popular OS Images"
    echo "18. Delete All Docker Images"
    echo "19. Create Database Images"
    echo "20. Build and Run Backend Tier 2 Image"
    echo "21. Run Docker Image by Name or ID"
    echo "22. Rebuild Existing Docker Image by Name or ID"
    echo "23. Exit"
    echo -n "Enter your choice: "
    read choice

    case $choice in
        1) docker images ;;
        2) echo -n "Enter OS name/version: "; read os; docker pull "$os" ;;
        3) docker pull ubuntu:14.04 ;;
        4) docker ps ;;
        5) echo -n "Enter Container ID/Name: "; read container_id; docker start "$container_id" ;;
        6) echo -n "Enter Container ID/Name: "; read container_id; docker stop "$container_id" ;;
        7) echo -n "Enter Container ID/Name: "; read container_id; docker rm "$container_id" ;;
        8) echo -n "Enter Image ID/Name: "; read image_id; docker rmi "$image_id" ;;
        9) echo -n "Enter Container ID/Name: "; read container_id; docker logs "$container_id" ;;
        10) docker stats ;;
        11) 
            echo -n "Enter Dockerfile Directory: "; read dir
            echo -n "Enter Image Name: "; read img
            docker build -t "$img" "$dir"
            ;;
        12)
            echo -n "Enter Image Name: "; read img
            echo -n "Enter Path to Save Tar: "; read path
            docker save -o "$path" "$img"
            ;;
        13)
            echo -n "Enter Path to Tar File: "; read path
            docker load -i "$path"
            ;;
        14)
            echo -e "1. List Networks\n2. Create Network\n3. Remove Network"
            read net_choice
            case $net_choice in
                1) docker network ls ;;
                2) echo -n "Enter Network Name: "; read net; docker network create "$net" ;;
                3) echo -n "Enter Network Name: "; read net; docker network rm "$net" ;;
            esac
            ;;
        15)
            echo -e "1. List Volumes\n2. Create Volume\n3. Remove Volume"
            read vol_choice
            case $vol_choice in
                1) docker volume ls ;;
                2) echo -n "Enter Volume Name: "; read vol; docker volume create "$vol" ;;
                3) echo -n "Enter Volume Name: "; read vol; docker volume rm "$vol" ;;
            esac
            ;;
        16)
            echo -e "1. nginx\n2. redis\n3. postgres\n4. node\n5. Other"
            read img_choice
            case $img_choice in
                1) docker pull nginx ;;
                2) docker pull redis ;;
                3) docker pull postgres ;;
                4) docker pull node ;;
                5) echo -n "Enter Image Name: "; read img; docker pull "$img" ;;
            esac
            ;;
        17)
            echo -e "1. Ubuntu\n2. Alpine\n3. Debian\n4. CentOS"
            read os_choice
            case $os_choice in
                1) docker pull ubuntu ;;
                2) docker pull alpine ;;
                3) docker pull debian ;;
                4) docker pull centos ;;
            esac
            ;;
        18)
            echo -n "Are you sure? (yes/no): "; read confirm
            [ "$confirm" = "yes" ] && docker rmi -f $(docker images -q)
            ;;
        19)
            echo "Database setup coming soon..." ;;
        20)
            echo "Backend setup coming soon..." ;;
        21)
            echo -n "Enter Image Name/ID: "; read img
            echo -n "Name the container? (y/n): "; read name_choice
            if [ "$name_choice" = "y" ]; then
                echo -n "Enter Container Name: "; read cname
                docker run -it --name "$cname" "$img"
            else
                docker run -it "$img"
            fi
            ;;
        22)
            echo -n "Enter Image Name/ID to rebuild: "; read img
            echo -n "Enter Dockerfile Directory: "; read dir
            echo -n "Enter Image Tag: "; read tag
            docker build -t "$img:$tag" "$dir"
            ;;
        23)
            echo "Exiting..."; break ;;
        *) echo "Invalid choice!" ;;
    esac

done
