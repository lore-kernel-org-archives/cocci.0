From: keescook@google.com (Kees Cook)
Date: Mon, 18 Jun 2018 10:59:35 -0700
Subject: [Cocci] Something like --exclude?
Message-ID: <CAGXu5j+AK-Bkv5k-wMpPt7asmU+AmusRjeFOSjwYqomD-PB0fA@mail.gmail.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Hi,

I normally use "--dir ." when doing recursive runs in the kernel tree,
but I want to avoid changes in the tools/ subdirectory. I can't find
anything like --exclude, and --dir can't be specified multiple times.
Is there an existing solution I'm missing?

Thanks!

-Kees

-- 
Kees Cook
Pixel Security
