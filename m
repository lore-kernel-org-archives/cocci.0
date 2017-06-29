From: okuznik@symas.com (=?utf-8?B?T25kxZllaiBLdXpuw61r?=)
Date: Thu, 29 Jun 2017 17:04:37 +0100
Subject: [Cocci] Matching format strings
Message-ID: <20170629160437.nvpn32fsetlzvni7@eos.mistotebe.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Hi all,
I'm looking into what's needed to replace OpenLDAP's debug macro
implementation which at the moment always takes 3 arguments:

Debug(LEVEL, "format", arg1, arg2, arg3);

to something more useful (and get rid of the obvious compiler warnings
we get from doing things like that).

There are two (or three) cases I need to handle where I hope coccinelle
would be able to help:

1. Where less than three arguments are needed, they are always filled
with zeros:

Debug(level, "text with less than three format specifiers", 0, 0, 0);

We want to change that to

Debug( level, "format" );

or equivalent. This is by far the most common one. But obviously where
we have zeros as arguments, but there is a corresponding % format
specifier, we don't want to drop those.

2. When more are needed, usually the code looks like this:

snprintf( buffer, size, "format", ... );
Debug( level, "text: %s\n", buffer, ... );

We'd like to change that to:

Debug( level, "new format", merged arguments );

There are fewer of those but still too many for a human to maintain
while we discuss the merits of this change on openldap-devel with
regards to C89, old compilers and stuff like that :)

2a. There might be a place that reuses the buffer contents, but that's
easy to check for I guess?

Looking around the docs and the archive, there is some python support,
but I have no idea how to use it yet to pick up the format strings, test
whether a Debug line matches and prepare the change.

Is coccinelle capable of expressing a semantic patch like that, and if
yes, do you have any pointers and suggestions about how I should go
about writing it?

Thanks!

-- 
Ond?ej Kuzn?k
Senior Software Engineer
Symas Corporation                       http://www.symas.com
Packaged, certified, and supported LDAP solutions powered by OpenLDAP
