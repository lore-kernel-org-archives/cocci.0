From: timur@kernel.org (Timur Tabi)
Date: Fri, 12 Oct 2018 18:08:46 -0500
Subject: [Cocci] Problem with improper multi-line string literals
In-Reply-To: <CAOZdJXWS0ABNYmz0WyDvVnxonGGELu6Qedi4nMfHrNHOsVwJ-Q@mail.gmail.com>
References: <CAOZdJXWJLLZdttCJmZVbZU9EEjxxHGdvnRCmT+3=8O=Cv4yx-w@mail.gmail.com>
 <alpine.DEB.2.21.1810122336171.2383@hadrien>
 <CAOZdJXWzDQay=sRwri7N_Hanzee1Qkwqg-ezLiY3_JToCp9kog@mail.gmail.com>
 <CAOZdJXWS0ABNYmz0WyDvVnxonGGELu6Qedi4nMfHrNHOsVwJ-Q@mail.gmail.com>
Message-ID: <CAOZdJXXcSEc0XkX-k=omA_yf4_SZFMYXmZwVXGcsjVRf+jhrDg@mail.gmail.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Fri, Oct 12, 2018 at 5:24 PM Timur Tabi <timur@kernel.org> wrote:>
I think now that my script is perfect.  Thanks again.

Looks like I spoke too soon.  It's modifying lines that are already
NV_PRINTF(), despite all the "depends on" that I have.  I want
Coccinelle to ignore any lines in the C file that are already
NV_PRINTF and just modify lines that are DBG_PRINTF.  But when I add
an NV_PRINTF() line to test.c, I get this:

-        DBG_PRINTF((DBG_MODULE_OS, DBG_LEVEL_ERRORS,
-                    "NVRM: %s: this is a test \
-                    of multiline " NvP64_fmt " strings %p\n",
-                    __FUNCTION__,
-                    p1,
-                    p2));
+        NV_PRINTF(LEVEL_ERROR,
+                  "this is a test of multiline " NvP64_fmt " strings %p\n",
+                  p1, p2);


-        NV_PRINTF(LEVEL_INFO, "%s\n", __FUNCTION__);
+        NV_PRINTF(LEVEL_INFO, "\n");

That second diff should not be there.

Looking at the output of --debug, I see it go through all the rules
and tell me what dependencies are satisfied, but it only does it once.
I would expect Coccinelle to re-evaluate all the rules for every line
of code it sees.  My script used to do that, so I broke it somehow.
