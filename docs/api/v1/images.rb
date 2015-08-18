=begin
  @api {get} /api/v1/images Request images list

  @apiGroup Images

  @apiParam {Number} [offset=0]
  @apiParam {Number} [limit=25]

  @apiHeader {String} Authorization Token that you get when register gadget

  @apiHeaderExample {string} Header example:
  Authorization: Token token="tOXYrlTa9jqf259ZjIIDLD8Ag1I5EwtEoacV6pwkkpUS+SIuDQOCff+YE4XB0Ha8p4VPUvuzb1RTWL2DbmXHEg=="

  @apiSuccessExample {json} Respon
  {
    "images": [
      {
        "id": "55d2f0721996da69ed000004",
        "filename": "631ee81d-99ee-46d2-ad74-bf30cb61d704.jpg",
        "sizes": [
          {
            "width": 100,
            "link": "http://resizer-api.herokuapp.com/api/images/63/1e/631ee81d-99ee-46d2-ad74-bf30cb61d704_100_x_100.jpg",
            "height": 100
          }
        ]
      },
      {
        "id": "55d2f3af1996da69ed00000c",
        "filename": "124d26c9-5e99-486d-ab82-dbe2689310f9.jpg",
        "sizes": [
          {
            "width": 100,
            "link": "http://resizer-api.herokuapp.com/api/images/12/4d/124d26c9-5e99-486d-ab82-dbe2689310f9_100_x_200.jpg",
            "height": 200
          }
        ]
      }
    ]
  }
=end

=begin
  @api {post} /api/v1/images/:id/resize Resize
  @apiGroup Images

  @apiDescription Handle request to resize images previously uploaded

  @apiParam {Number} width Resized image width
  @apiParam {Number} height Resized image height

  @apiHeaderExample {string} Header example:
  Content-Type: application/json
  Authorization: Token token="tOXYrlTa9jqf259ZjIIDLD8Ag1I5EwtEoacV6pwkkpUS+SIuDQOCff+YE4XB0Ha8p4VPUvuzb1RTWL2DbmXHEg=="

  @apiErrorExample {json} Error response exemple:
  {
    "errors": {
      "width": [
        "can't be blank",
        "is not a number"
      ],
      "height": [
        "can't be blank",
        "is not a number"
      ]
    }
  }

  @apiParamExample {json} Request body example:
  {
    "width": 100,
    "height": 100
  }

  @apiSuccessExample {json} Respon
  {
    "width": 300,
    "link": "http://resizer-api.herokuapp.com/api/images/63/1e/631ee81d-99ee-46d2-ad74-bf30cb61d704_300_x_300.jpg",
    "height": 300
  }
=end

=begin
  @api {post} /api/v1/images Upload
  @apiGroup Images

  @apiDescription Upload image and resize it to setted parameters

  @apiParam {Number} width Resized image width
  @apiParam {Number} height Resized image height
  @apiParam {File} file Uploaded file

  @apiHeader {String} Authorization Token that you get when register gadget
  @apiHeader {String} Content-type Have to be multipart/form-data to allow to upload file

  @apiHeaderExample {string} Header example:
  Content-Type: multipart/form-data; boundary=9351D444-773E-4221-A24F-15F8770A8D29
  Authorization: Token token="tOXYrlTa9jqf259ZjIIDLD8Ag1I5EwtEoacV6pwkkpUS+SIuDQOCff+YE4XB0Ha8p4VPUvuzb1RTWL2DbmXHEg=="

  @apiErrorExample {json} Error response exemple:
  {
    "errors": {
      "width": [
        "can't be blank",
        "is not a number"
      ],
      "height": [
        "can't be blank",
        "is not a number"
      ]
    }
  }

  @apiSuccessExample {json} Respon:
  {
    "width": 300,
    "link": "http://resizer-api.herokuapp.com/api/images/63/1e/631ee81d-99ee-46d2-ad74-bf30cb61d704_300_x_300.jpg",
    "height": 300
  }
=end