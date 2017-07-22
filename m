From: hlovdal@gmail.com (=?UTF-8?B?SMOla29uIEzDuHZkYWw=?=)
Date: Sat, 22 Jul 2017 13:34:04 +0200
Subject: [Cocci] Dropping K&R support
In-Reply-To: <alpine.DEB.2.20.1707142005580.3699@hadrien>
References: <20170714172922.sziksfhmacwmoqph@eos.mistotebe.net>
 <alpine.DEB.2.20.1707142005580.3699@hadrien>
Message-ID: <CAACXqO9ZMBjQpzk4S5vJA_r_vhEaNAVgpJD9vttBDER0vFBRhQ@mail.gmail.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On 14 July 2017 at 20:07, Julia Lawall <julia.lawall@lip6.fr> wrote:
> On Fri, 14 Jul 2017, Ond?ej Kuzn?k wrote:
>> Hi,
>> in OpenLDAP we're thinking of dropping K&R support macros in our
>> headers, but I'm having problems generating the semantic patch that
>> would work.
>>...
>> @@
>> @@
>>
>> -LDAP_P(
>>  ...
>> -)
>>
> Sorry, it can't be done.  You rule wants to match an expression, not
> something around bits of a function header.

Overall a plain text search and replace would probably give 99.??% solution,
but one possibility would be to write a custom LDAP_P removal program
which in a case like this is not complicated at all. To remove all occurrences
of LDAP_P in code, you just need to keep a state if you are inside a comment
or inside a string and do no replacement in those cases.

The program StripCmt, http://www.bdc.cx/software/stripcmt/, which removes
comments from C source code, almost does all the parsing needed and it
is very simple to modify/extend. I once wrote a program to replace all
strings in code with empty strings like

-        const char * message = "hello";
-        printf("\"message\" = %s\n", message); // prints: "message" = hello
+        const char * message = "";
+        printf("", message); // prints: "message" = hello

and it was almost no work at all to do by basing the program on
stripcmt's source code (which is just ~200 lines of code).

BR H?kon L?vdal
