From: timur@kernel.org (Timur Tabi)
Date: Tue, 16 Oct 2018 17:49:11 -0500
Subject: [Cocci] __asm statements confuse spatch
Message-ID: <CAOZdJXWvGOK3M0w_2N3ZXoLWSeJaJfC-UeHhfo6cG_qyLOFxJw@mail.gmail.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

I'm trying to modify a Windows .c file, and it contains several __asm
(or _asm or asm) statements that confuse spatch.  They look like this:

    _asm {mov ax, ss}
    __asm mov uRetval,eax                // Just keep 32 bits.
    __asm {
        PAUSE
        PAUSE
    }

And so on.  Is there a way to get spatch to ignore these statements?

Another problem I've having with the source file is that it has
inconsistent usage of braces, and sometimes spatch wants to add
unnecessary braces that look off.  For example, this:

        if (...)
            DBG_PRINTF((...));
        else
            DBG_PRINTF((...));
        }

(the } belongs to some if-statement much earlier in code somewhere) becomes:

        if (...) {
            NV_PRINTF(...);
        }
        else {
            NV_PRINTF(...);
        }
        }

I really don't want spatch to add the braces.
