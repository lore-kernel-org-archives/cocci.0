From: timur@kernel.org (Timur Tabi)
Date: Fri, 12 Oct 2018 17:24:17 -0500
Subject: [Cocci] Problem with improper multi-line string literals
In-Reply-To: <CAOZdJXWzDQay=sRwri7N_Hanzee1Qkwqg-ezLiY3_JToCp9kog@mail.gmail.com>
References: <CAOZdJXWJLLZdttCJmZVbZU9EEjxxHGdvnRCmT+3=8O=Cv4yx-w@mail.gmail.com>
 <alpine.DEB.2.21.1810122336171.2383@hadrien>
 <CAOZdJXWzDQay=sRwri7N_Hanzee1Qkwqg-ezLiY3_JToCp9kog@mail.gmail.com>
Message-ID: <CAOZdJXWS0ABNYmz0WyDvVnxonGGELu6Qedi4nMfHrNHOsVwJ-Q@mail.gmail.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Fri, Oct 12, 2018 at 4:42 PM Timur Tabi <timur@kernel.org> wrote:
> That made a huge difference, thanks.  I still need to keep the Python
> code that merges the string into one line, but that could be just for
> my own code vs Coccinelle's parser.

One drawback with your version is that it doesn't compress parameters
into fewer lines, like the original did, so I added this rule at the
very end:

// Finally, compress all the parameters into as few lines as possible
@depends on rules@
expression list x;
@@
-NV_PRINTF(x);
+NV_PRINTF(x);

I think now that my script is perfect.  Thanks again.
