From: julia.lawall@lip6.fr (Julia Lawall)
Date: Tue, 19 Feb 2013 23:05:21 +0100 (CET)
Subject: [Cocci] [Coccinellery] drop_continue/cont.cocci broken ?
In-Reply-To: <5123E41C.30603@gmail.com>
References: <5123E41C.30603@gmail.com>
Message-ID: <alpine.DEB.2.02.1302192304080.2092@localhost6.localdomain6>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Actually, I changed it as follows, for the for loop case:

@@
statement S;
@@

for (...;...;...) {
  ...
  if (...)
  {
+   DROP_ME();
    S
-   continue;
  }
}

@@
statement S;
@@
  if (...)
- {
-   DROP_ME();
    S
- }

I just hope that no one puts a call to DROP_ME at the top of an if...  
It's not foolproof, but it does allow the rule to do the transformation.

julia
