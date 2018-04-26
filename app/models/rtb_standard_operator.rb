class RtbStandardOperator

    attr_accessor :value,:name

    def self.all
        [
            { value:1, name: "EQUALS"},
            { value:2, name: "NOT_EQUALS"},
            { value:3, name: "MEMBER"},
            { value:4, name: "NOT_MEMBER"},
            { value:5, name: "INTERSECTS"},
            { value:6, name: "NOT_INTERSECTS"},
            { value:7, name: "INRANGE"},
            { value:8, name: "NOT_INRANGE"},
            { value:9, name: "LESS_THAN"},
            { value:10, name: "LESS_THAN_EQUALS"},
            { value:11, name: "GREATER_THAN"},
            { value:12, name: "GREATER_THAN_EQUALS"},
            { value:13, name: "DOMAIN"},
            { value:14, name: "NOT_DOMAIN"},
            { value:15, name: "STRINGIN"},
            { value:16, name: "NOT_STRINGIN"},
            { value:17, name: "EXISTS"},
            { value:18, name: "NOT_EXISTS"},
            { value:19, name: "OR"},
            { value:20, name: "REGEX"},
            { value:21, name: "NOT_REGEX"}
        ].sort_by{|i| i[:name] }
    end
    
end

__END__

	public static final int EQUALS = 1;
	/* Test for inequality */
	public static final int NOT_EQUALS = 2;
	/** Test for set membership */
	public static final int MEMBER = 3;
	/** Test for not membership */
	public static final int NOT_MEMBER = 4;
	/** Test set intersection */
	public static final int INTERSECTS = 5;
	/** Test not intersection */
	public static final int NOT_INTERSECTS = 6;
	/** Test lat/lon range with other lat/lon, in km */
	public static final int INRANGE = 7;
	/** Test not in range */
	public static final int NOT_INRANGE = 8;
	/** Test less than numeric */
	public static final int LESS_THAN = 9;
	/** Test less than equal numeric */
	public static final int LESS_THAN_EQUALS = 10;
	/** Test greater than numeric */
	public static final int GREATER_THAN = 11;
	/** Test greater than equal numeric */
	public static final int GREATER_THAN_EQUALS = 12;
	/** Test in domain x less than y greater than z */
	public static final int DOMAIN = 13;
	/** Test not in domain */
	public static final int NOT_DOMAIN = 14;
	/** Test the string is a substring of another */
	public static final int STRINGIN = 15;
	/** Test the string not a substring in another */
	public static final int NOT_STRINGIN = 16;
	/** Does an attribute exist in the rtb request */
	public static final int EXISTS = 17;
	/** Does an attribute not exist in the rtb reqest */
	public static final int NOT_EXISTS = 18;
	/** Does an attribute not exist in the rtb reqest */
	public static final int OR = 19;