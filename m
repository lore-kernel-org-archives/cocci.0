From: me@tobin.cc (tcharding)
Date: Mon, 20 Mar 2017 10:23:45 +1100
Subject: [Cocci] [PATCH] Add package manager install dependencies hint
Message-ID: <1489965825-28589-1-git-send-email-me@tobin.cc>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

From: Tobin C. Harding <me@tobin.cc>

Install.txt lists the build dependencies of Coccinelle. These may
be able to be installed as a one line command. Add text to illuminate
this possibility including example commands for apt-get, dnf, and yum.

Suggested-by: Peter Senna Tschudin <peter.senna@gmail.com>

Signed-off-by: Tobin C. Harding <me@tobin.cc>
---
 install.txt | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/install.txt b/install.txt
index 485cb46..4a24665 100644
--- a/install.txt
+++ b/install.txt
@@ -36,6 +36,15 @@ On Fedora, install the following packages
  - ocaml-menhir (optional, bundled)
  - ocaml-pcre-devel (optional, bundled)
 
+You can try to use the package manager of your distribution to install
+the build dependencies. This is not guaranteed to work, as the
+dependencies may change, but chances are it will help you. Some
+examples:
+
+$ apt-get build-dep coccinelle
+$ dnf builddep coccinelle
+$ yum builddep coccinelle
+
 Then simply type
  ./configure
  make
-- 
2.7.4
