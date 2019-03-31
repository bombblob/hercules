;;; start-project.el --- Start project of a specific type
;; Author: Alexander Carlson <alexandercarlson99@gmail.com>
;; Maintainer: Alexander Carlson <alexandercarlson99@gmail.com>
;; Created: 31 Mar 2019
;; Keywords: project
;; This file is not part of GNU Emacs.

;;; Commentary:
;; Hercules project for 42 Silicon Valley
;; The goal is to make a simple script to make starting projects easier/faster

;;; Code:

(defun clone-gitignore ()
  "Clone gitignore template."
  (if (y-or-n-p "Clone gitignore? ")
	  (progn
		(if (file-exists-p ".gitignore")
			(message ".gitignore file exists.  Skipping clone-gitignore")
		  (progn
			(message "cloning gitignore")
			(shell-command "git clone https://github.com/bombblob/gitignore_template.git gitignore_dir")
			(rename-file "gitignore_dir/.gitignore" "./.gitignore")
			(shell-command "rm -rf gitignore_dir"))))
	(message "skipping clone-gitignore")))

(defun clone-libft ()
  "Clone libft."
  (if (y-or-n-p "Clone libft? ")
	  (progn
		(if (file-exists-p "libft")
			(message "libft exists.  Skipping clone-libft")
		  (progn
			(message "cloning libft")
			(shell-command "git clone https://github.com/bombblob/libft.git libft")
			(shell-command "rm -rf libft/.git"))))
	(message "skipping clone-libft")))

(defun make-author ()
  "Create author file."
  (if (y-or-n-p "Create author file? ")
	  (progn
		(if (file-exists-p "author")
			(message "author file exists.  Skipping make-author")
		  (progn
			(message "creating author file")
			(append-to-file user-login-name nil "author")
			)))
	(message "skipping make-author")))

(defun git-init-project (repo-url)
  "Initialize git repo and maybe push to REPO-URL."
  (interactive "sRepo url(blank to skip) ")
  (if (string= repo-url "")
	  (message "Skipping git-init-project")
	(progn
	  (if (file-exists-p ".git")
		  (message ".git file exists.  Skipping git-init-project")
		(progn
		  (if (shell-command (format "git init && git add . && git commit -m \"First commit\" && git remote add origin %s && git push -u origin master" repo-url))
			  (message "PUSH FAILED")
			(message "push successful")))))))

(defun start-project-c ()
  "Start a c project."
  (message "Starting c project")
  (make-author)
  (clone-gitignore)
  (clone-libft)
  (if (file-exists-p "src")
	  (message "src dir exists.  Skipping creation")
	(make-directory "src"))
  (if (file-exists-p "inc")
	  (message "inc dir exists.  Skipping creation")
	(make-directory "inc"))
  (if (file-exists-p "lib")
	  (message "lib dir exists.  Skipping creation")
	(make-directory "lib"))
  (if (file-exists-p "Makefile")
	  (message "Makefile exists.  Skipping creation")
	(with-temp-file "Makefile"
	  (insert "")))
  (git-init-project (read-from-minibuffer "Repo url(blank to skip) ")))

(defun start-project-c++ ()
  "Start a c++ project."
  (message "Starting c++ project")
  (make-author)
  (clone-gitignore)
  (clone-libft)
  (if (file-exists-p "src")
	  (message "src dir exists.  Skipping creation")
	(make-directory "src"))
  (if (file-exists-p "inc")
	  (message "inc dir exists.  Skipping creation")
	(make-directory "inc"))
  (if (file-exists-p "lib")
	  (message "lib dir exists.  Skipping creation")
	(make-directory "lib"))
  (if (file-exists-p "Makefile")
	  (message "Makefile exists.  Skipping creation")
	(with-temp-file "Makefile"
	  (insert "")))
  (git-init-project (read-from-minibuffer "Repo url(blank to skip) ")))

(defun start-project-rust ()
  "Start a rust project."
  (message "Starting rust project")
  (make-author)
  (clone-gitignore)
  (if (file-exists-p "src")
	  (message "src dir exists.  Skipping creation")
	(progn
	  (make-directory "src")
	  (with-temp-file "src/main.rs"
		(insert "fn main() {\n\tprintln!(\"Hello, world!\");\n}"))
	  ))
  (if (file-exists-p "Cargo.toml")
	  (message "Cargo.toml exists.  Skipping creation")
	(progn
	  (with-temp-file "Cargo.toml"
		(insert (format "[package]\nname = \"NAME\"\nversion = \"0.1.0\"\nauthors = [\"%s\"]\nedition = \"%s\"\n\n[dependencies]\n" user-login-name (format-time-string "%Y"))))
	  ))
  (git-init-project (read-from-minibuffer "Repo url(blank to skip) ")))

(defun start-project-help ()
  "Help option for start-project."
  (message "This simply creates a series of files/directories depending on the type of project specified")
  (message "supported options: c c++ rust help"))

(defun start-project (project-type)
  "Clone gitignore, libft(?), first push(?)\
and start project of type PROJECT-TYPE."
  (interactive "sWhat type of project?(help to show help message) ")
  (cond
   ((string= project-type "c")
	(start-project-c))
   ((string= project-type "c++")
	(start-project-c++))
   ((string= project-type "rust")
	(start-project-rust))
   ((string= project-type "help")
	(start-project-help))
   ((= 1 1)
	(message "usage: M-x start-project help"))))

(provide 'start-project)
;;; start-project.el ends here