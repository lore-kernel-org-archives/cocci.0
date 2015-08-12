From: kborer@gmail.com (Kris Borer)
Date: Wed, 12 Aug 2015 10:49:19 -0400
Subject: [Cocci] [RFC] coccinelle: add style check for assignment in if
In-Reply-To: <alpine.DEB.2.10.1508121558480.2527@hadrien>
References: <1439387500-11183-1-git-send-email-kborer@gmail.com>
 <alpine.DEB.2.10.1508121558480.2527@hadrien>
Message-ID: <CAMy_N61ctHDPupmzBe1XagV7cysiUu9drC7vM0cFLq=rz3=QXA@mail.gmail.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Wed, Aug 12, 2015 at 10:00 AM, Julia Lawall <julia.lawall@lip6.fr> wrote:

> Thanks for the contribution.  Have you checked very carefully that it
> doesn't eg pull XXX out of if (E && XXX)?  (I don't know if it does or it
> doesn't, but it is a common pitfall with this issue).
>
> thanks,
> julia
>

?I tested it and it seems okay. The details are below. Let me know if you
meant something else or would like a more involved test.

?bash> cat test.c
int f() {
    return 0;
}

int main() {

    int a;

    // if1 good
    if( a = f() ) {
        a = 1;
    }

    // if1 bad
    if( a == 1 && (a = f()) ) {
        a = 1;
    }

    // if2 good
    if( (a = f()) < 0 ) {
        a = 1;
    }

    // if2 bad
    if( a == 1 && (a = f()) < 0 ) {
        a = 1;
    }

    // if4 good
    if( (a = f()) < 0 && a != 0 ) {
        a = 1;
    }
    // if4 bad
    if( a == 1 && (a = f()) < 0 && a != 0 ) {
        a = 1;
    }

    // if5 good
    if( (a = f()) < 0 && a != 0 ) {
        a = 1;
    }
    // if5 bad
    if( a == 1 && (a = f()) < 0 && a != 0 ) {
        a = 1;
    }

    return 0;
}
bash> spatch --sp-file assignment_in_if.cocci test.c
init_defs_builtins: /usr/local/lib/coccinelle/standard.h
warning: if4: metavariable E3 not used in the - or context code
HANDLING: test.c
diff =
--- test.c
+++ /tmp/cocci-output-11515-32ee81-test.c
@@ -7,7 +7,8 @@ int main() {
     int a;

     // if1 good
-    if( a = f() ) {
+    a = f();
+    if(a) {
         a = 1;
     }

@@ -17,7 +18,8 @@ int main() {
     }

     // if2 good
-    if( (a = f()) < 0 ) {
+    a = f();
+    if(a < 0 ) {
         a = 1;
     }

@@ -27,7 +29,8 @@ int main() {
     }

     // if4 good
-    if( (a = f()) < 0 && a != 0 ) {
+    a = f();
+    if(a < 0 && a != 0 ) {
         a = 1;
     }
     // if4 bad
@@ -36,7 +39,8 @@ int main() {
     }

     // if5 good
-    if( (a = f()) < 0 && a != 0 ) {
+    a = f();
+    if(a < 0 && a != 0 ) {
         a = 1;
     }
     // if5 bad
?
Thanks,

?Kris Borer?
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <https://systeme.lip6.fr/pipermail/cocci/attachments/20150812/b53e6227/attachment.html>
