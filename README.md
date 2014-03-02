# Application benc

## Handling of bencoded data

This Erlang library (application) contains the code for a bencoder and decoder as used in Etorrent. It is pulled out to its own repository so other projects can refer safely to it without having to pull in the full etorrent source code.

http://en.wikipedia.org/wiki/Bencode

The `bencode` format is used by BitTorrent as an extensible serialization format. It is used in BitTorrent whenever raw speed is of no concern, but where it is nice to have a way to later extend the format. The format describes a way to store and transmit loosely structured data. As such, the format works like most other data-at-rest-formats in that it is:

* Self-describing
* Somewhat human readable

Contenders would be something like:

* JSON
* XML
* data.fressian
* edn
* UBF
* ASN.1
* Protobufs
* Thrift

and so on. This format is just the particular format BitTorrent happens to use. It is also a very simple format.

## Building

Execute:

	make deps app
	
To run the tests, you need to pull a couple of test dependencies and then run them:

	make build-tests tests
	
The tests use `PropEr` in order to run a property based test of the correct isomorphism between the Erlang representation and the underlying wire format.

## Use

Module `benc` operates on a specific type called `bcode()`. Its rule is given in the `benc` module as an exported type. Given a bencoded string, it can be decoded into Erlang by using:

	case benc:decode(BEncoded) of
	    {ok, Parsed} -> …;
	    {error, Reason} -> …
	end,
	
if `BEncoded` contains excess data, it is thrown away. This is to handle certain badly written encoders. Also, the value `[]` represents the empty array, whereas the value `{}` is used as a representation of the empty dicitionary, since we need a way to discriminate them.

In the other direction, you need a valid `bcoded` value, for example

	Data = [{<<"a">>, 37}, {<<"b">>, <<"Hello World">>}],
	IOList = benc:encode(Data),
	…
	
The encoded data is given as an `iolist()`. You will need to call `iolist_to_binary/1` on it to flatten it to a binary, but note that for most output cases, this is not necessary.

For convenience, there is also a way to quickly parse a file

	{ok, Decoded} = benc:parse_file("foo.torrent"),
	…

