Generate the package list using:

     apm list --installed --bare > package-list.txt

Import it with 

    apm install --packages-file ./package-list.txt
