From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Sat, 18 Jul 2015 15:36:39 +0200
Subject: [Cocci] Finding unstored return values with SmPL
In-Reply-To: <alpine.DEB.2.02.1507181451340.2016@localhost6.localdomain6>
References: <55A62135.90206@users.sourceforge.net>
 <alpine.DEB.2.10.1507150629540.2670@hadrien>
 <55AA3B1F.5020807@users.sourceforge.net>
 <alpine.DEB.2.02.1507181351130.2042@localhost6.localdomain6>
 <55AA476F.7020907@users.sourceforge.net>
 <alpine.DEB.2.02.1507181451340.2016@localhost6.localdomain6>
Message-ID: <55AA5667.5010009@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> Between the regular expression and the undefined dependencies,
> I have no idea what you are trying to do.

I would present the "gap" (further SmPL rules) there if the main rule
will be clear for the suggested top-down design approach.


> Maybe just give an example of code that you would like to match.

I would like to achieve a bit of functionality which is already provided
by other popular static source code analysis tools to some degree
also by means of the Coccinelle software.

Other tools can also detect unused/unchecked return values.
Examples:
http://www.splint.org/manual/html/sec8.html#_Toc534974997
https://gcc.gnu.org/onlinedocs/gcc-5.2.0/gcc/Function-Attributes.html#index-g_t_0040code_007bwarn_005funused_005fresult_007d-function-attribute-3299


The SmPL approach that we are discussing now should point open issues out
in source code like the following small test example.

int implementation_with_an_ignored_return_value(void)
{
 malloc(123);
 return 0;
}


I imagine that a complete solution would need a detailed data flow analysis
for this purpose. But I am not familiar enough will all necessary
technology there so far.

So I hope that a smaller solution can be achieved with Coccinelle.
* I can find an ordinary function call without problems.

* The corresponding software development challenges become apparent
  when I would like to ensure by a SmPL filter that the source code position
  of this call is different from all other function calls which were detected
  at other places within a function implementation.

  @show_unstored_return_values
   depends on !find_calls_for_initialisations
           && !find_calls_for_designated_initialisations
           && !find_calls_for_assignments@

  Should this dependency specification be extended anyhow?

Regards,
Markus
