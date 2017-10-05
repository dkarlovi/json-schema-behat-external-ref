Feature: JSON Schema test

  Scenario: Validating JSON Schema from Behat works
    Given there is a response equal to:
    """
    [
      {"id": "a", "name": "a", "created_at": "2010-01-01T12:00:00Z", "created_by": {"id": "a", "username": "a"}, "updated_at": "2010-01-01T12:00:00Z", "updated_by": {"id": "a", "username": "a"}},
      {"id": "b", "name": "b", "created_at": "2010-01-01T12:00:00Z", "created_by": {"id": "b", "username": "b"}, "updated_at": "2010-01-01T12:00:00Z", "updated_by": {"id": "b", "username": "b"}}
    ]
    """
    Then the JSON should be valid according to this schema:
        """
        {
            "definitions": {
                "user": {
                    "type": "object",
                    "required": ["id", "username"],
                    "properties": {
                        "id": {"type": "string", "format": "udid"},
                        "username": {"type": "string"}
                    },
                    "additionalProperties": false
                },
                "image": {
                    "type": "object",
                    "required": ["id", "name"],
                    "properties": {
                        "id": {"type": "string", "format": "udid"},
                        "name": {"type": "string"},
                        "created_at": {"type": "string", "format": "date-time"},
                        "created_by": {"$ref": "#/definitions/user"},
                        "updated_at": {"type": "string", "format": "date-time"},
                        "updated_by": {"$ref": "#/definitions/user"}
                    },
                    "additionalProperties": false
                }
            },
            "type": "array",
            "items": {"$ref": "#/definitions/image"},
            "minItems": 2,
            "maxItems": 2,
            "uniqueItems": true,
            "additionalItems": false
        }
        """

  Scenario: Validating JSON Schema from Behat with external $refs works
    Given there is a response equal to:
    """
    [
      {"id": "a", "name": "a", "created_at": "2010-01-01T12:00:00Z", "created_by": {"id": "a", "username": "a"}, "updated_at": "2010-01-01T12:00:00Z", "updated_by": {"id": "a", "username": "a"}},
      {"id": "b", "name": "b", "created_at": "2010-01-01T12:00:00Z", "created_by": {"id": "b", "username": "b"}, "updated_at": "2010-01-01T12:00:00Z", "updated_by": {"id": "b", "username": "b"}}
    ]
    """
    Then the JSON should be valid according to this schema:
    """
    {
        "type": "array",
        "id": "features/my.feature",
        "items": {"$ref": "schemas/image.json"},
        "minItems": 2,
        "maxItems": 2,
        "uniqueItems": true,
        "additionalItems": false
    }
    """

