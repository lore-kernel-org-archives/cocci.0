From: joe@perches.com (Joe Perches)
Date: Wed, 30 Aug 2017 03:49:05 -0700
Subject: [Cocci] cocci script to add static to const declarations ?
Message-ID: <1504090145.2786.16.camel@perches.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Any idea on how to write a cocci script that
looks for const array declarations and adds
static to them only when all the initializers
of the array are constants?

For instance:

    int foo(int bar)
    {
    	    const int baz[] = {1, 2, 3};
    }

could be converted to

    int foo(int bar)
    {
    	    static const int baz[] = {1, 2, 3};
    }

but

    int foo(int bar)
    {
    	    const int baz[] = {1, 2, 3, bar};
    }

would not be converted?
