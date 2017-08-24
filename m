From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Thu, 24 Aug 2017 17:23:39 +0200
Subject: [Cocci] parsing of C code
In-Reply-To: <alpine.DEB.2.20.1708241219540.3187@hadrien>
References: <alpine.DEB.2.20.1708231104310.3150@hadrien>
 <8fcfa4a0-678a-f8f3-003a-9c953ba36c11@users.sourceforge.net>
 <alpine.DEB.2.20.1708241219540.3187@hadrien>
Message-ID: <2114627e-6e0c-62ae-5fc5-901858f744d5@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> Parsing of foo fails due to the attribute __xxx(yyy) that Coccinelle is
> not able to cope with.

* Do you find information relevant from answers to a question like
  ?Context-free grammars versus context-sensitive grammars???
  https://stackoverflow.com/questions/8236422/context-free-grammars-versus-context-sensitive-grammars#answer-8250104

* Do the ?attributes? which you would like to support trigger a need
  to work with context-dependent grammars?

* Did you ask any other developers (or software designers) for
  possible solutions around the mentioned aspect?

* Will the software situation improve any more also for the
  programming language ?OCaml? (besides tools like ?Menhir?)?

Regards,
Markus
