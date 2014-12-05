From: joe@perches.com (Joe Perches)
Date: Thu, 04 Dec 2014 17:12:31 -0800
Subject: [Cocci] Finding embedded function names?
Message-ID: <1417741951.2721.30.camel@perches.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Is it possible for coccinelle to look at the name
of a function that might be embedded in a format?

ie for:

void testme(void)
{
	printf("testme: some message\n");
}

Can it find the "testme" embedded in a format string?
