From: travis.friesen@micropilot.com (Travis Friesen)
Date: Mon, 16 Jun 2014 10:39:44 -0500
Subject: [Cocci] Type change errors
Message-ID: <13B51409AF4D26439D6326248B3C48D10266972250F3@lilienthal.MICROPILOT.COM>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Hi There

I'm trying to use Coccinelle to change the types in a large, legacy codebase. Basically, most of our code was written using 'int's and 'long's, but the coding standard we are trying to adhere to (MISRA C:2012, for those keeping score) mandates the use of non-builtin types, such as int32_t, etc

There are certain corner cases that a simple sed wouldn't catch, such modifying the contents of Doxygen comments, so I thought I'd see if I can get Coccinnelle to do what we want. And for simple cases, it seems to work quite well. The following rules

@ rule1 @
identifier i1;
@@

(
- unsigned int i1;
+ uint32_t i1;
|
- unsigned long i1;
+ uint32_t i1;
)


@ rule2 @
identifier i1;
@@

(
- int i1;
+ int32_t i1;
|
- long i1;
+ int32_t i1;
)


Catch the bulk of our 32-bit integer usage in declarative statements, but it's obviously going to miss a lot of stuff, including function definitions and prototypes. My attempts to use more sophisticated rules, such as

@ rule25 @
identifier i2;
@@

unsigned
(
  - long i2;
|
  - int i2;
)
+ uint32_t i2;


Or

@ rule4 @
identifier fn;
identifier i2;
@@

fn(...
   - int i2
   + int32_t i2
  ...)


Result in a mysterious (and unhelpful) "minus: parse error..." Even trying to omit the semicolons does not work. The very basic:

@ rule3 @
identifier i2;
@@

   - int i2
   + int32_t i2


Also throws a "minus parse error...". But from what I understand, the semicolon should not be a necessary component to Coccinelle syntax.

Am I on the right track here? I feel that I am missing something simple and obvious, but my rules follow the same-ish format of the examples I've read. Alas, there are no examples of anyone trying to change the types of integers that I can find.

Thanks for your help.
Travis
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <https://systeme.lip6.fr/pipermail/cocci/attachments/20140616/9f63016c/attachment.html>
