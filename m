From: julia.lawall@lip6.fr (Julia Lawall)
Date: Mon, 11 Jun 2018 12:49:54 +0200 (CEST)
Subject: [Cocci] Support for C++ delete expressions
In-Reply-To: <c8f05f51-fa3c-9770-ac99-20a23df8e4c3@users.sourceforge.net>
References: <169e2663-6c92-c6ce-4b27-47d8494490f4@users.sourceforge.net>
 <alpine.DEB.2.20.1806031831320.2242@hadrien>
 <7e3bd4a1-daaf-5b84-5de2-c446cc0a4c1c@users.sourceforge.net>
 <alpine.DEB.2.20.1806032126430.2740@hadrien>
 <c8f05f51-fa3c-9770-ac99-20a23df8e4c3@users.sourceforge.net>
Message-ID: <alpine.DEB.2.20.1806111248510.3334@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

delete [] is now supported by the C++ parser (ie with option --c++).  Note
that no C++ specific operators are supported by the semantic patch
language.

julia
