From: me@tobin.cc (Tobin C. Harding)
Date: Wed, 11 Oct 2017 11:07:45 +1100
Subject: [Cocci] prinkt specifiers
Message-ID: <20171011000745.GD2049@eros>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Hi,

Is it possible to craft a coccinelle script to find and replace calls (in the kernel) that are
printing pointers using %x.

Perhaps we could easily catch the calls that are casting the pointer within argument list, for example

	pr_info("x: %llx\n", (unsigned long long int)ptr);

I'm happy to try and work out how to do it, just chasing a 'yes that is exactly the type of thing
cocci is good at' or a 'no, you are dreaming, perhaps <this tool> can do that'

thanks,
Tobin.
