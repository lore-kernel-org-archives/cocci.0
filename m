From: julia.lawall@lip6.fr (Julia Lawall)
Date: Mon, 16 Jan 2017 07:32:40 +0100 (CET)
Subject: [Cocci] rework a function to move parameters around ....
In-Reply-To: <CAP6exY+oh2PAxaYvSHbkXTBAfLPpTsb4tXXPG-5TRQQ54Nw1Ag@mail.gmail.com>
References: <CAP6exYJV8O6siwkwin4B+_R=PSOR9HthOfGe0DJsqXaPrN44yg@mail.gmail.com>
 <alpine.DEB.2.20.1701160718350.1947@hadrien>
 <CAP6exY+oh2PAxaYvSHbkXTBAfLPpTsb4tXXPG-5TRQQ54Nw1Ag@mail.gmail.com>
Message-ID: <alpine.DEB.2.20.1701160731500.1947@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Basically, I just went for the brute force solution of listing all the
possible orderings of the code.

This is sort of analogous to the semantic patch for adding uses of
setup_timer in the kernel.

julia
