define(['utils/canvas'], function (utils) {


  describe('bezier function', function () {

    beforeEach(function () {
      utils.points = [{x:100, y: 100}, {x:500, y:100}, {x:100, y:500}, {x:500, y:500}];
    });

    it("should return correct Binom values", function () {
      expect(utils.getBinom(5, 3)).toEqual(10);
      expect(utils.getBinom(0, 0)).toEqual(1);
    });

    it("should return correct Bezier coeff", function () {
      expect(utils.getBezierCoeff(5, 5, 1, 100)).toEqual(100);
      expect(utils.getBezierCoeff(5, 4, 1, 100)).toEqual(0);
    });

    it("should return correct Bezier total", function () {
      expect(utils.getBezierFormula(3, 1, 1, 'x')).toEqual(500);
      expect(utils.getBezierFormula(3, 0, 1, 'x')).toEqual(100);
    });

  });
});

