From: sagawa.aki@gmail.com (Akihiro Sagawa)
Date: Sat, 13 May 2017 21:40:03 +0900
Subject: [Cocci] [bug-cocci] deadcode detection
Message-ID: <20170513213826.751B.375B48EC@gmail.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Hello, julia and folks,
I found the following source code (deadcode.c) isn't updated by semantic
patch (deadcode.cooci) with spatch version 1.0.4.

[deadcode.c]
int deadcode(const char* c)
{
    do {
        if (c) {
            foo(*c);
            break;
        }
        break;
    } while (0);
}

[deadcode.cocci]
@@
expression E;
@@
-foo(E)
+bar(E)

With `--debug` option, spatch shows `FLOW: deadcode detected: File
"./deadcode.c", line 3`. But, I think there is no deadcode. There is
just a redundant `break` at the end of the loop. In my opinion, although
it's a bit strange, `break` keyword is harmless like the last `break`
keyword in the last label block in a `switch` statement, e.g.

switch (*c) {
  case 'x': x++; break;
  case 'y': y++; break;
  default:
    warn("Invalid input: %c\n", *c);
    break; // <-- this is harmless, not a deadcode
}

Practical issue is seen in Wine 2.7's dlls/shlwapi/url.c from line 707
to 874. I tried to replace isalnum() to isalnumW(), a WCHAR version of
isalnum(),@line 812. However, spatch missed it without warnings. You
can see https://source.winehq.org/source/dlls/shlwapi/url.c?v=wine-2.7#0707
for the source code.

I'll be happy if spatch finds out the above case and makes a patch for it.
Deadcode.{c,cocci} are available in the Github pull requests.

Thanks in advance,
Akihiro Sagawa
