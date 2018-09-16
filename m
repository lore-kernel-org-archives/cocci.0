From: moustafa@cmpsamurai.com (Moustafa Mahmoud)
Date: Sun, 16 Sep 2018 16:58:03 +0200
Subject: [Cocci] Strange behavior with replacing multiple typedefs
Message-ID: <CAKCTf_YQgm-tgnsvfF6hV=sd+GjRU41XniWJqmoBFzwyDSr1-Q@mail.gmail.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Hello all,
I am facing this problem with typedefs, what I am trying to achieve is
convering multiple typedefs into single ones.


typedef int x,y;

into :

typedef  int x;
typedef int y;


when I try to replace them inside functions, everything works as expected\

My Rule :
@rule1@
identifier fn;
type t;
metavariable mm;
@@

++ typedef t mm;
fn(...){
<+...
- typedef t mm;
...+>
}

The C Code

typedef int;
typedef int mr,e4;

int main()
{
    typedef int sss, ssd;
}

The Diff :
diff =
--- typedef.c
+++ /tmp/cocci-output-91048-e42770-typedef.c
@@ -3,7 +3,8 @@
 typedef int;
 typedef int mr,e4;

+typedef int ssd;
+typedef int sss;
 int main()
 {
-    typedef int sss, ssd;
 }
\ No newline at end of file


However if I try to generalize it

@rule1@
type t;
metavariable mm;
@@

++ typedef t mm;
- typedef t mm;



The C Code:

typedef int;
typedef int mr,e4;

int main()
{
    typedef int sss, ssd;
}

What I get is this :

 typedef int;
-typedef int mr,e4;
+typedef int e4;
+typedef int mr;
+typedef int;

 int main()
 {
-    typedef int sss, ssd;
+    typedef int ssd;
+    typedef int sss;
+    typedef int;
 }
\ No newline at end of file


You can notice the extra  "+  typedef int;" , why are those produced ? is
there a way to achieve what  want without them ?

Thank you very much.
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <https://systeme.lip6.fr/pipermail/cocci/attachments/20180916/4f7fbf15/attachment.html>
