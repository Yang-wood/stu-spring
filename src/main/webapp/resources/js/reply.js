/**
 * 
 */
 console.log("Reply Module.................");
 
 // 기명 함수 표현식
/*var buyCar = function(carName) {
	console.log("내가 구매하고 싶은 차는 " + carName + "입니다.");
};

buyCar("아우디 Q9"); 

 // 즉시 실행 함수 표현식
 (function(carName) {
	console.log("내가 구매하고 싶은 차는 " + carName + "입니다.");
}("아우디 Q9"));*/

var replyService = (function() {
	//댓글 추가
	function add(reply, callback, error) {
		console.log("add reply...............");
		
		$.ajax({
			type : "post",
			url : "/replies/new",
			data : JSON.stringify(reply),			
			contentType : "application/json; charset=utf-8",
			success : function(result, status, xhr) {
				//xhr : 비동기 통신을 담당하는 자바스크립트 객체
				
				if(callback) {
					callback(result);
				}
			},
			error : function(status, xhr, err) {
				if(error) {
					error(err);
				}
			}
		});
	}
	//댓글 목록
	function getList(param, callback, error) {
		var bno = param.bno;
		var page = param.page || 1;
		
		$.getJSON("/replies/pages/" + bno + "/" + page,
				function(data) {
					if(callback) {
						callback(data.replyCnt, data.list);
					}
				}).fail(function(xhr, status, err) {
					if(error) {
						error();
					}
				});
	}
	
	//댓글 삭제
	function remove(reply, callback, error) {
		$.ajax({
			type : "delete",
			url : "/replies/" + reply.rno,
			success : function(deleteResult, status, xhr) {
				if(callback) {
					callback(deleteResult);
				}
			},
			error : function(xhr, status, err) {
				if(error) {
					error(err);
				}
			}
			
		});
	}
	
	//댓글 수정
	function update(reply, callback, error) {
		console.log("RNO : " + reply.rno);
		
		$.ajax ({
			type : "put",
			url : "/replies/" + reply.rno,
			data : JSON.stringify(reply),
			contentType : "application/json; charset=utf-8",
			success : function(result, status, xhr) {
				if(callback) {
					callback(result);
				}
			},
			error : function(xhr, status, err) {
				if(error) {
					error(err);
				}
			}
		});
	}
	
	//댓글 조회
	function get(reply, callback, error) {
		$.get("/replies/" + reply.rno, function(result) {
			if(callback) {
				callback(result);
			}
		}).fail(function(xhr, status, err) {
			if(error) {
					error(err);
				}
		});
	}
	
	//댓글 시간 처리
	function displayTime(timeValue) {
		var today = new Date();
		
		var gap = today.getTime() - timeValue;
		
		var dateObj = new Date(timeValue);
		var str = "";
		
		if(gap < (1000 * 60 * 60 * 24)) {
			var hh = dateObj.getHours();
			var mi = dateObj.getMinutes();
			var ss = dateObj.getSeconds();
			
			return [ (hh > 9 ? '' : '0') + hh, ':', 
			(mi > 9 ? '' : '0') + mi, ':', (ss > 9 ? '' : '0') + ss].join('');
		} else {
			var yy = dateObj.getFullYear();
			var mm = dateObj.getMonth() + 1;
			var dd = dateObj.getDate();
			
			return [yy, '/', (mm > 9 ? '' : '0') + mm, '/', 
			(dd > 9 ? '' : '0') + dd].join('');
		}
	
	}
	
	return {
				add : add,
				get : get,
				getList :getList,
				remove : remove,
				update : update,
				displayTime : displayTime
			};
})();











 