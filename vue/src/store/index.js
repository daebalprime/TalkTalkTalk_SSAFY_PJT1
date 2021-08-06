import { createStore } from "vuex";
import axios from "@/axios";
import createPersistedState from "vuex-persistedstate";
import { moduleQna } from "@/store/modules/moduleQna";
import { auth } from "@/store/modules/auth";
import { userQna } from "@/store/modules/userQna"

export default createStore({
  plugins: [
    createPersistedState({
      paths: ["auth"],
    }),
  ],
  modules: { moduleQna, auth, userQna },
  state: {
    //user-info: state.auth.user로 사용하면 됨
    rooms: {},
    selected_room: null, // 클릭한 채팅방의 세션id를 저장
    session_key: {},
    //qnahistory를 아마 넣을 예정
    list_status: "LIVE",
  },
  mutations: {
    GET_ROOMS(state, payload) {
      state.rooms = payload;
    },
    ADD_ROOMS(state, payload) {
      payload.messages = [];
      state.session_key = payload;
    },
    PICK_ROOM(state, payload) {
      state.selected_room = payload;
    },
    USER_MSG_PUSH(state, payload) {
      state.session_key.messages.push(payload);
      //방이 대기 상태일 때, msg가 처음 들어오면 live로 바꿈
      if (state.session_key.status == "OPEN") {
        state.session_key.status = "LIVE";
      }
    },
    MESSAGE_PUSH(state, payload) {
      state.rooms[`${state.selected_room}`].messages.push(payload);
    },
    SAVE_USER_CHAT_ROOM_ID(state, payload) {
      state.selected_room = payload;
    },
    STATUS_CHANGE(state, payload) {
      state.list_status = payload;
    },
  },
  actions: {
    async getChatRooms({ commit, state }) {
      try {
        const res = await axios.get(`api/api/chat/admin/init/${state.auth.user.pk_idx}`);
        commit("GET_ROOMS", res.data);
      } catch (error) {
        console.log(error);
      }
    },
    async createChatRooms({ commit, state }) {
      try {
        const res = await axios.post("api/api/chat/room", {
          unread: 0,
          fk_created_by_idx: state.auth.user.pk_idx, // 상담 신청하는 고객의 userid
          fk_client_idx: state.auth.user.pk_idx, // 위 필드와 동일값 넣어주면 됨.
          status: "OPEN", //아마 default 값
        });
        commit("ADD_ROOMS", res.data); //rooms에 저장
        commit("SAVE_USER_CHAT_ROOM_ID", res.data.session_id); //selected_id
      } catch (error) {
        console.log(error);
        alert("채팅방 개설 실패");
      }
    },
    pickRoom({ commit }, key) {
      commit("PICK_ROOM", key);
    },
  },
  getters: {
    get_messages: (state) => {
      return state.rooms[`${state.selected_room}`].messages;
    },
    get_room_list: (state) => {
      let roomList = [];
      for (let i in state.rooms) {
        let room = state.rooms[i];
        if (room.session.status === state.list_status) {
          roomList.push(room);
        }
      }
      roomList.sort(function (a, b) {
        return a.session.created_at > b.session.created_at ? -1 : 1;
      });
      return roomList;
    },
    get_user_messages: (state) => {
      // return state.session_key[`${state.selected_room}`].messages;
      console.log(state.session_key);
      return state.session_key.messages;
    },
    get_user_room_status: (state) => {
      return state.session_key.status;
    },
  },
});
